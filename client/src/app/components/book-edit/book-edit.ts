
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { BookService } from '../../services/book';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-book-edit',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './book-edit.html'
})
export class BookEdit implements OnInit {
  bookForm: FormGroup;
  isEditMode = false;

  constructor(private fb: FormBuilder, private bookService: BookService) {
    this.bookForm = this.fb.group({
      Id: [null],
      Title: ['', Validators.required],
      AuthorName: ['', Validators.required],
      Description: [''],
      CategoryName: [''],
      StatusName: ['']
    });
  }

  ngOnInit(): void {}

  save() {
    if (this.bookForm.valid) {
      if (this.isEditMode) {
        // הקומפוננטה לא יודעת מה השם של הפרוצדורה, היא רק קוראת לפונקציה
        this.bookService.updateBook(this.bookForm.value).subscribe(() => {
          alert('עודכן בהצלחה!');
        });
      } else {
        this.bookService.addBook(this.bookForm.value).subscribe(() => {
          alert('נוסף בהצלחה!');
        });
      }
    }
  }
}