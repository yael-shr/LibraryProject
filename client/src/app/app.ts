import { Component, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';
import { BookListComponent } from './components/book-list/book-list'; 

@Component({
  selector: 'app-root',
  standalone: true, 
  imports: [RouterOutlet, HttpClientModule, BookListComponent], 
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
  protected readonly title = signal('library-client');
}