```css
table { width: 100%; }
thead { display: none; }

td {
  border: none !important;
  padding-left: 20% !important;
  display: block;
}

td:before {
  content: attr(data-title);
  position: absolute;
  left: 6px;
  font-weight: bold;
}
```