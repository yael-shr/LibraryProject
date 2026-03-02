import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BookService } from '../../services/book';
import { Book } from '../../models/book.model';

@Component({
  selector: 'app-book-list',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './book-list.html'
})
export class BookListComponent implements OnInit {
  books: Book[] = []; 

  constructor(private bookService: BookService) {}

  ngOnInit(): void {
    this.loadBooks(); 
  }
loadBooks() {
  this.bookService.getAllBooks().subscribe((data: any) => {
    console.log('הנה הספרים שהגיעו:', data); // תסתכלי מה כתוב כאן!
    this.books = data.value || data; // Handle both array and object with 'value' property
  });
}
}