<!DOCTYPE html>
 <html>
 <head> 
	<link href="./CSS/homePage.css" rel="stylesheet">
 </head>
	<body>
		<!-- Links at the top of the page -->
		<div class="nav">
				<ul>
				  <li><a href="#" class="nav-link">My Profile</a></li>
				  <li><a href="#" class="nav-link">Q&A</a></li>
				  <li><a href="logout.jsp" class="nav-link">Logout</a></li>
				  <% if (session.getAttribute("userType").equals("admin")) { %>
				  <li><a href="adminPage.jsp" class="nav-link">Admin Tools</a></li>
				  <% } %>
				  <% if (session.getAttribute("userType").equals("customerRep")) { %>
				  <li><a href="customerRepPage.jsp" class="nav-link">Customer Rep Tools</a></li>
				  <% } %>
				</ul>
		  </div>
		<!-- Main body -->
		<h1> Welcome 
		<%
			if (session.getAttribute("userType").equals("admin")) {
				out.println(session.getAttribute("user") + " (Administrator)");
			} else if (session.getAttribute("userType").equals("customerRep")) {
				out.println(session.getAttribute("user") + " (Customer Representative)");
			} else {
				out.println(session.getAttribute("user"));
			}
		%>! </h1>

		<div class="search">
			<form class="search-form" action="/action_page.php">
			  <input type="text"class="searchTerm" placeholder="Search by Product Title: Celtics, Kobe" name="search">
			  <button type="submit">Submit</button>
			</form>
		</div>

		<div class="product-tabs">
			<div class="sports-cards">
					<button type="button">Sports</button>
			</div>
			<div class="pokemon-cards">
					<button type="button">Pokemon</button>
			</div>
			<div class="movie-cards">
					<button type="button">Movies</button>
			</div>
		</div>

		<div class="product-container">
			<div class="filter-settings">
			  <h4>Search Settings</h4>
			  <form method="post" action="newBarBeerPrice.jsp">
				<!-- autograph -->
				<p class="label" >Autographed?</p>
				<input type="checkbox" id="checkbox" name="vehicle1"/>
				<label >Yes</label><br />
				<br />
	  
				<!-- bidding price range -->
				<p class="label" for="dog-names">Bidding Price Range</p>
				<input type="number" id="price-input" min="0" placeholder="Min" />
				<br />
				<input type="number" id="price-input" min="0" placeholder="Max" />
	  
				<br />
				<br />
	  
				<!-- sport-options -->
				<div class="sport-options">
				  <p class="label" for="dog-names">Choose a Sport:</p>
				  <select id="sport-names">
					<option value="basketball">basketball</option>
					<option value="baseball">baseball</option>
					<option value="soccer">soccer</option>
					<option value="football">football</option>
				  </select>
				</div>
				<br />
				<!-- sport-options -->
				<button type="submit">Search!</button>
			  </form>
			</div>
			<div class="product-list">
					  <h4>Results For: Sports</h4>
					  
					  <div class="product-cards">
						  <div class="product-card">
							  <div class="product-card-wrapper">
									  <div class="product-img">
										  <img src="https://m.media-amazon.com/images/I/91aqUnvcdRL._AC_SL1500_.jpg">
									  </div>
									  <div class="product-info">
										  <div class="product-text">
											  <h2>Harvest Vase</h2>
											  <h4>by studio and friends</h4>
											  <p>3 Bids</p>
											  <p>6 Days Left</p>
											  <p>Current Bidding Price: 78$</p>
										  </div>
										  <div class="product-price-btn">
											  <button type="button">Bid Now!</button>
										  </div>
								  </div>
						  </div>
						  <div class="product-card">
							  <div class="product-card-wrapper">
									  <div class="product-img">
										  <img src="http://bit.ly/2tMBBTd">
									  </div>
									  <div class="product-info">
										  <div class="product-text">
											  <h2>Harvest Vase</h2>
											  <h4>by studio and friends</h4>
											  <p>3 Bids</p>
											  <p>6 Days Left</p>
											  <p>Current Bidding Price: 78$</p>
										  </div>
										  <div class="product-price-btn">
											  <button type="button">Bid Now!</button>
										  </div>
								  </div>
						  </div>
					  </div>
			</div>
		  </div>
	</body>
</html>
	