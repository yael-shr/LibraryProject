import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { BookService } from '../../services/book';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-delete-book',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './delete-book.html'
})
export class DeleteBook implements OnInit {
  bookId: number | null = null;

  constructor(
    private route: ActivatedRoute,
    private bookService: BookService,
    private router: Router
  ) {}

  ngOnInit(): void {
  
    this.bookId = Number(this.route.snapshot.paramMap.get('id'));
  }

  confirmDelete(): void {
    if (this.bookId) {
      this.bookService.deleteBook(this.bookId).subscribe({
        next: () => {
          alert('הספר נמחק בהצלחה!');
          this.router.navigate(['/']);
        },    
        error: (err) => console.error('שגיאה במחיקה:', err)
      });
    }
  }

  cancel(): void {
    this.router.navigate(['/']); 
  }
}