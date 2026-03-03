import { Routes } from '@angular/router';
import { BookListComponent } from './components/book-list/book-list';
import { BookDetails } from './components/book-details/book-details';

export const routes: Routes = [
  { path: '', component: BookListComponent }, // הדף הראשי יציג את הרשימה
  { path: 'book/:id', component: BookDetails } // דף הפרטים
];