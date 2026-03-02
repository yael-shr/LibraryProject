var builder = WebApplication.CreateBuilder(args);

// --- הוספה: הגדרת מדיניות CORS ---
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAngularApp",
        policy =>
        {
            policy.WithOrigins("http://localhost:4200") // הכתובת של האנגולר שלך
                  .AllowAnyHeader()
                  .AllowAnyMethod();
        });
});
// --------------------------------

builder.Services.AddControllers();
builder.Services.AddOpenApi();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.UseSwagger();
    app.UseSwaggerUI();
}

// --- הוספה: שימוש במדיניות שהגדרנו ---
// חשוב מאוד: זה חייב להופיע לפני MapControllers ולפני UseAuthorization
app.UseCors("AllowAngularApp");
// --------------------------------

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

app.Run();