<div class="tabs">
  <input type="radio" id="tab1" name="tabs" checked>
  <label for="tab1">Tab One</label>
  <div class="tab">
    <p>This is the content of Tab One</p>
  </div>

  <input type="radio" id="tab2" name="tabs">
  <label for="tab2">Tab Two</label>
  <div class="tab">
    <p>This is the content of Tab Two</p>
  </div>

  <input type="radio" id="tab3" name="tabs">
  <label for="tab3">Tab Three</label>
  <div class="tab">
    <p>This is the content of Tab Three</p>
  </div>
</div>

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
