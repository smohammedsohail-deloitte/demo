<div class="tabs">
  <input type="radio" id="tab1" name="tabs" checked>
  <label for="tab1">Tab 1</label>
  <div class="tab">
    <p>Content for Tab 1 goes here.</p>
  </div>

  <input type="radio" id="tab2" name="tabs">
  <label for="tab2">Tab 2</label>
  <div class="tab">
    <p>Content for Tab 2 goes here.</p>
  </div>

  <input type="radio" id="tab3" name="tabs">
  <label for="tab3">Tab 3</label>
  <div class="tab">
    <p>Content for Tab 3 goes here.</p>
  </div>
</div>

<style>
.tabs {
  display: flex;
  flex-wrap: wrap;
  margin: 0;
  padding: 0;
  list-style: none;
  border: 1px solid #ccc;
  border-radius: 5px;
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
</style>
