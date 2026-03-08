import { Routes } from '@angular/router';
import { BookListComponent } from './components/book-list/book-list';
import { BookDetails } from './components/book-details/book-details';
import { BookEdit } from './components/book-edit/book-edit';
import { DeleteBook } from './components/delete-book/delete-book';

export const routes: Routes = [
  { path: '', component: BookListComponent }, 
  { path: 'book/:id', component: BookDetails },
  { path: 'books/add', component: BookEdit },
  { path: 'books/edit/:id', component: BookEdit},
  { path: 'books/delete/:id', component: DeleteBook}
];