// src/app/services/book.service.ts

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

  getAllBooks(): Observable<Book[]> {
    return this.execute('Books_GetAll_Search');
  }

  deleteBook(bookId: number): Observable<any> {
    return this.execute('DeleteBook', { id: bookId });
  }
}