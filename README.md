<!-- 
    data-item="tab-name"
    The correspondent data-view value that will be render 
-->

<!-- 
    data-initial="true" 
    The initial rendered tab view. 
    Will be appended the class .tab-active automatically on each click event
-->

<!-- 
    data-view="tab-view-name"
    The tab view name. 
    Will be rendered when the correspondent data-item is clicked
-->

<ul id="tabbar"> <!-- Tab Links id -->
    <!-- Tab Links Children -->
    <li data-item="tab-one tab-active" data-initial="true">Tab One</li>
    <li data-item="tab-two">Tab Two</li>
    <li data-item="tab-three">Tab Three</li>
    <li data-item="tab-four">Tab Four</li>
</ul>

<div id="tabview"> <!-- Tab View id  -->
    <!-- Tab View Children -->
    <h1 data-view="tab-one">
        Tab 1
    </h1>
    <h1 data-view="tab-two">
        Tab 2
    </h1>
    <h1 data-view="tab-three">
        Tab 3
    </h1>
    <h1 data-view="tab-four">
        Tab 4
    </h1>
</div>
