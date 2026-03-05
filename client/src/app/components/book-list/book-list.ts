import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BookService } from '../../services/book';
import { Book } from '../../models/book.model';
import { RouterLink } from '@angular/router';
import { ChangeDetectorRef } from '@angular/core';

@Component({
  selector: 'app-book-list',
  standalone: true,
  imports: [CommonModule,RouterLink],
  templateUrl: './book-list.html',
  styleUrl: './book-list.css' 
})
export class BookListComponent implements OnInit {
  books: Book[] = []; 

  constructor(private bookService: BookService ,private cdr: ChangeDetectorRef) {}

  ngOnInit(): void {
    this.loadBooks(); 
  }
  
loadBooks() {
  this.bookService.getAllBooks().subscribe((data: any) => {
    console.log('הנה הספרים שהגיעו:', data); 
    this.books = data.value || data; 
    this.cdr.detectChanges();
  });
}
}