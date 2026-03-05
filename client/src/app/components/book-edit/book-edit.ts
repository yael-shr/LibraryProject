
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { BookService } from '../../services/book';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router'; 
import { Router } from '@angular/router'; 
import { ChangeDetectorRef } from '@angular/core';

@Component({
  selector: 'app-book-edit',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './book-edit.html',
  styleUrl: './book-edit.css'
})
export class BookEdit implements OnInit {
  bookForm: FormGroup;
  isEditMode = false;
  authors: any[] = [];
  book: any = {}; 
  categories: any[] = [];
  statuses: any[] = [];

    constructor(private fb: FormBuilder, private bookService: BookService, private route: ActivatedRoute,private router: Router,private cdr: ChangeDetectorRef) {
    this.bookForm = this.fb.group({
    Id: [null],
    Title: ['', Validators.required],
    AuthorId: [null, Validators.required], 
    Description: [''],
    CategoryId: [null], 
    StatusId: [null]   
    }
   );
  }
  
  onSubmit(): void {
    if (this.bookForm.valid) {
      console.log('Form submitted:', this.bookForm.value);
      this.save();
    } else {
      console.log('Form is invalid');
    }
  } 

  ngOnInit(): void {const id = this.route.snapshot.paramMap.get('id');
  if (id) {
    this.isEditMode = true;
    this.bookService.getBookById(Number(id)).subscribe(book => {
      const bookData = Array.isArray(book) ? book[0] : book;
      this.bookForm.patchValue(bookData);
    });
  } else {
    this.isEditMode = false;
  }
  this.bookService.getCategories().subscribe((data: any) => {
    console.log('Categories arrived:', data);
    this.categories = data.value || data; 
  });
  
 this.bookService.getStatuses().subscribe((data: any) => {
    console.log('Statuses arrived:', data); 
    this.statuses = data.value || data;
  });
  this.bookService.getAuthors().subscribe((data: any) => {
    console.log('Authors arrived:', data);
    this.authors = data.value || data;
    this.cdr.detectChanges()
  });
}
save() {
  if (this.bookForm.valid) {
    const formData = this.bookForm.value;

    if (this.isEditMode) {
      const updateData = {
        Id: Number(formData.Id),
        Title: formData.Title,
        Description: formData.Description || '',
        AuthorId: Number(formData.AuthorId),
        CategoryId: Number(formData.CategoryId),
        StatusId: Number(formData.StatusId)
      };
      
      this.bookService.updateBook(updateData as any).subscribe({
        next: () => { alert('עודכן בהצלחה!'); this.router.navigate(['/']); },
        error: (err) => console.error('שגיאת עדכון:', err)
      });
    } else {
      const createData = {
        Title: formData.Title,
        Description: formData.Description || '',
        AuthorId: Number(formData.AuthorId),
        CategoryId: Number(formData.CategoryId),
        StatusId: Number(formData.StatusId)
      };

      this.bookService.addBook(createData as any).subscribe({
        next: () => { alert('נוסף בהצלחה!'); this.router.navigate(['/']); },
        error: (err) => console.error('שגיאת הוספה:', err)
      });
    }
  }
}
}