# My Project

## Overview

```html
<div class="tabs">
  <input type="radio" id="tab1" name="tabs" checked>
  <label for="tab1">Introduction</label>
  <div class="tab">
    <p>Welcome to my project!</p>
  </div>

  <input type="radio" id="tab2" name="tabs">
  <label for="tab2">Features</label>
  <div class="tab">
    <ul>
      <li>Feature 1</li>
      <li>Feature 2</li>
      <li>Feature 3</li>
    </ul>
  </div>

  <input type="radio" id="tab3" name="tabs">
  <label for="tab3">Requirements</label>
  <div class="tab">
    <ul>
      <li>Requirement 1</li>
      <li>Requirement 2</li>
      <li>Requirement 3</li>
    </ul>
  </div>
</div>
```

```css
.tabs {
  display: flex;
  flex-wrap: wrap;
  margin: 0;
  padding: 0;
  list-style: none;
  border-bottom: 1px solid #ccc;
}

.tabs label {
  display: block;
  padding: 10px 20px;
  margin-right: 10px;
  border: 1px solid #ccc;
  border-bottom: none;
  cursor: pointer;
}

.tabs label:hover {
  background-color: #f9f9f9;
}

.tabs input[type="radio"] {
  display: none;
}

.tabs input[type="radio"]:checked + label {
  background-color: #fff;
  border-color: #ccc;
  border-bottom-color: #fff;
}

.tab {
  display: none;
  padding: 20px;
  border: 1px solid #ccc;
  border-top: none;
}

.tabs input[type="radio"]:checked ~ .tab {
  display: block;
}
```

You can see that we've used three backticks followed by the language name ("html" or "css") to indicate that the code is HTML or CSS. When you view the Markdown file in a Markdown viewer, the HTML and CSS code will be displayed in a code block. You can also include inline HTML and CSS code using the appropriate syntax. Here's an example:

```markdown
# My Project

## Overview

<div class="tabs">
  <input type="radio" id="tab1" name="tabs" checked>
  <label for="tab1">Introduction</label>
  <div class="tab">
    <p>Welcome to my project!</p>
  </div>

  <input type="radio" id="tab2" name="tabs">
  <label for="tab2">Features</label>
  <div class="tab">
    <ul>
      <li>Feature 1</li>
      <li>Feature 2</li>
      <li>Feature 3</li>
    </ul>
  </div>

  <input type="radio" id="tab3" name="tabs">
  <label for="tab3">Requirements</label>
  <div class="tab">
    <ul>
      <li>Requirement 1</li>
      <li>Requirement 2</li>
      <li>Requirement 3</li>
    </ul>
  </div>
</div>

<style>
.tabs {
  display
