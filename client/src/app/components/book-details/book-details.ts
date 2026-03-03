import { Component, OnInit } from '@angular/core';
import { BookService } from '../../services/book';
import { Book } from '../../models/book.model';
import { CommonModule } from '@angular/common';
import { ChangeDetectorRef } from '@angular/core';
import { ActivatedRoute, RouterModule } from '@angular/router';

@Component({
  selector: 'app-book-details',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './book-details.html',
  styleUrl: './book-details.css' 

})
export class BookDetails implements OnInit {
  book: Book | undefined;

  constructor(
    private route: ActivatedRoute,
    private bookService: BookService,
    private cdr: ChangeDetectorRef
  ) {}

// בקובץ src/app/components/book-details/book-details.ts
ngOnInit(): void {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    if (id) {
      this.bookService.getBookById(id).subscribe((data: any) => {
        // אם הנתונים מגיעים כערך בתוך אובייקט, או כמערך ישירות
        const result = data.value || data;
        
        // כאן התיקון: אם זה מערך, ניקח את האיבר הראשון שבו
        this.book = Array.isArray(result) ? result[0] : result;
        this.cdr.detectChanges();
      });
    }
  }
}
  
