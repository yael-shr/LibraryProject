import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Book } from '../models/book.model';

@Injectable({
  providedIn: 'root' 
})
export class BookService {
  
  private apiUrl = 'https://localhost:7182/api/exec'; 

  constructor(private http: HttpClient) { }

  private execute(spName: string, parameters: any = {}): Observable<any> {
    const request= {
      procedureName: spName, 
    parameters: parameters || {}
    };
    return this.http.post<any>(this.apiUrl, request);
  }

  public executeSP(spName: string, parameters: any = {}): Observable<any> {
    return this.execute(spName, parameters);
  }

  getAllBooks(): Observable<Book[]> {
    return this.execute('Books_GetAll_Search');
  }

  deleteBook(bookId: number): Observable<any> {
    return this.execute('DeleteBook', { id: bookId });
  }

  addBook(book: Book): Observable<any> {
return this.execute('Books_Create', book);  }

  updateBook(book: Book): Observable<any> {
    return this.execute('Books_Update', book);
  }

getBookById(bookId: number): Observable<Book> {
  return this.execute('Books_GetById', { id: bookId });
}
getCategories(): Observable<any[]> {
  return this.execute('Categories_GetAll'); 
}
getStatuses(): Observable<any[]> {
  return this.execute('Statuses_GetAll');
}
getAuthors(): Observable<any[]> {
  return this.execute('Authors_GetAll'); 
}
}