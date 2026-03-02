using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient; 
using System.Data;             
using System.Collections.Generic;
using ServerHouses;
using Microsoft.Extensions.Configuration;

namespace ServerHouses.Controllers
{
    [Route("api/")]
    [ApiController]
    public class HousesController : ControllerBase
    {
        private readonly string _connectionString;

        public HousesController(IConfiguration configuration)
        {
 
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        private List<Dictionary<string, object>> ConvertToList(DataTable dt)
        {
            var list = new List<Dictionary<string, object>>();

            foreach (DataRow row in dt.Rows)
            {
                var dict = new Dictionary<string, object>();

                foreach (DataColumn col in dt.Columns)
                {
                    dict[col.ColumnName] = row[col];
                }

                list.Add(dict);
            }

            return list;
        }

        [HttpPost("exec")]
        public IActionResult Post([FromBody] MyJson request)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(request.procedureName, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (request.parameters != null)
                        {
                            foreach (var param in request.parameters)
                            {
                                cmd.Parameters.AddWithValue(param.Key, param.Value ?? DBNull.Value);
                            }
                        }

                        conn.Open();

                        DataTable dt = new DataTable();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }

                        return Ok(ConvertToList(dt)); 
                    }
                }
            }
            catch (Exception ex)
            {
                return BadRequest(new { error = ex.Message });
            }
        }

    }
}









