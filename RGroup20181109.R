

  #=================================================#
  #                  								
  #  No Free Lunch: Paying for Program R
  #
  #  OSU R Workshop  2018-11-09           	
  #
  #																		
  #	 Derek B. Spitz
  #
  #  derek.spitz@oregonstate.edu
  #
  #  www.cityofkitesandcrows.com
  #
  #  Script will be available @github.com/dbspitz/howtoR
  #					
  #=================================================#

  starttime <- Sys.time()

  #	Goals today: 
  #     1) Efficiency
  #     2) Shared Language
  #     3) Building Tools
  #
  #  The Perennial Problem: https://xkcd.com/844/
  #
  #  I. Behold, the Power of R
  #			A. Do I have a tool that does that?
  #			B. If so, how does it work?
  #			C. omg wtf
  #
  #  II. What IS this?
  #			A. Objects  (...have a class!)
  #     B. Methods  (...why class matters!)
  #		  C. Back to Our Starting Examples...
  #
  #  III. Reinventing Wheels
  #     A. Loops
  #     B. Vectorization 
  #     C. *apply
  #
  #
  #		If you're curious about how R works, 
  # 		consider checking out:
  #
  # 			"The Art of R Programming"
  # 					by Norman Matloff
  #
  # 	(available as an ebook through OSU?)
  #
  
  
  ##----------------------------------------------------------------------------
  # I. Behold, the power...

      # A. Do I have a tool that does that?
	      # Example 1: Say we want a plot of a landscape that shows perspective... 
	    
		      # (1): Search installed packages
          ??perspective   # shortcut to help by keyword-- what are our options?
		      
          # (2): Check a Specific Package
          library(help = raster)
          
          # (3): Search for a function by name
          ?persp			# shortcut to help file if you know the function name
          
          # and/or (4) Google it up!
  
  
		  # B. If so, How does it work?
		      example(persp)  # example code/plots for "persp"

	      # Example 2	(Distribution of Animal Use)
		      library(help = "adehabitatHR") # package documentation
		      library(adehabitatHR)  # load package ("require" would also work)
	    
	        ?kernelUD
	        example(kernelUD)
	
          # Some cleanup...
		      objects()  # what is in R right now?
		      rm(list = objects())  # blank the slate... 
		      objects()
		
		    # Lots more Data...
		      data()  # R datasets by package
	        ?discoveries # check for metadata

          # Some you can look at without loading...
		      discoveries
		      head(quakes) # Top 6 records only
	        tail(warpbreaks)  # Bottom 6 records only
	
	        # Others you have to load first...
	        objects()
	        meuse
	        data(meuse) # load data
	        objects()    
		      head(meuse) 
		
		      
	  # C. Let's recreate an example...
		# From "example(kernelUD)" (first plot):
  		  ## Load the data
		  data(puechabonsp)
		  loc <- puechabonsp$relocs
 
		  ## have a look at the data]
		  head(as.data.frame(loc))
	      tail(as.data.frame(loc))
	    
		  ## the first column of this data frame is the ID
		  ud <- kernelUD(loc[,1])

        ## Estimation of UD for the four animals
		    image(ud)			

        # Cool! But what is "ud"?
		    ud		#??!?


  ##----------------------------------------------------------------------------
  # II.  What is it?-- Object Oriented Programming 

    # A. Objects
      # Everything we handle in R is an object
      # Every object has a class	

      a <- "all"
      b <- 2
      d <- TRUE
      
      # What class is "a"?
		  class(a)
		  
		  # "b"? 		
		  class(b)
		  
		  # "d"?
		  class(d)
		  
		  # what about "c" & "e"?
      class(c)
      class(e)
      
		
	  # Some Objects are Complex: 			
      # i. vector (atomic)--1 dimension
        vec1 <- c(5, b)
        class(vec1)
        
		    # after adding d?
        class(c(vec1, d)) 
		
		    #after adding a?
		    class(c(vec1, a))

        # Will the last elements of these vectors be the same?
        c(b, d)
        (vec2 <- c(a, b, d))

        # Propose a hierarchy of the classes we'e seen so far?

        # What if we remove "a" from "vec2"?
        vec2[-1] # class?

      # ii. matrix (and arrays)	-- data in 2 or more dimensions
        M <- matrix(nrow = 3, ncol = 2)
		    M
		    is.matrix(M) # another way of checking class...
		    class(M)
		    
		    # a matrix has "attributes" that a vector doesn't
		    attributes(M)
		    attributes(vec1)
		    
		    # Is "M" logical?
		    is.logical(M) 
		    
		    M[2, 2] <- TRUE # Let's set the second column in the second row to 1
		    M		
				
		    # Does this change M's class?
	    	is.logical(M)
        str(M)

		    # What if we assign "a" to the last value of the second column?
        a
        M[3,1] <- a
        str(M)

      # iii. list --recursive vectors
		    list1 <- list("Log" = c(d), "Num" = c(b, d), "Chr" = vec2)
		    # What class(es) is list 1?
		    class(list1)
			  is.character(list1)
			  is.numeric(list1)
			  is.logical(list1)

		    length(list1[3])
		    length(list1[[3]])
			
	      attributes(list1)
	 	    str(list1)
		    names(list1)
	
			
		    list1[1]
		    str(list1[1])
		    is.character(list1$Chr)
		    is.character(list1$Num)
		
		    # What if we wanted to get the class for each element in "list1"...
		    ?lapply  # *apply family: Very Useful!; TBC...
		    lapply(list1, class)  

      # iv. dataframe --???
        class(warpbreaks)
		    length(warpbreaks) # what is this returning?
			    M; length(M)  # ...compared to?
			    vec1; length(vec1)
			    head(warpbreaks)  # Trust, but verify
			    ncol(warpbreaks)
		      nrow(warpbreaks)
		      str(warpbreaks)			
			
		    # What is this thing?
		    is.data.frame(warpbreaks)
		    is.matrix(warpbreaks)        
        is.list(warpbreaks)

      # v. functions
		    # what is "str"? "lapply"? Are they objects?
	      class(str)

		    # what about simple opperators like ":" or "+" ? (like we'd use in"1+4" or "5:10")
        ?":"
	      ?"+"
	      1 + 4
	      "+"(1, 4)
	      5:10
	      ":"(5, 10)
		    ?"?"  # Even the question mark: shortcut to "Documentation Shortcuts"
		    ?"??" # ==> Shortcut to help.search()

		    # Are there differences between functions and the other classes we've seen?
	      as.ltraj
	      print


    # B. Methods 
	    # i. Example 1: Storing and Displaying Date/Time
	      starttime  # (This is an implicit call to "print")
	      (starttime)
	      print(starttime)
	      class(unclass(starttime))
		    unclass(starttime)  # Easiest way to see the importance of class: remove it!
		    class(starttime)
		    ?POSIXct  # Many classes have descriptions that can be helpful

		    unclass(starttime)/(60*60*24*365.25)
		    starttimeLT <- as.POSIXlt(starttime)
		    str(starttimeLT)
		    unclass(starttimeLT)
		    str(unclass(starttimeLT))
		    starttimeLT
		    
		    # So what's happening behind the curtain?
		    methods(print) # not something you need to know, but worth taking a peek...


	    # ii. Example 2: Plotting Location Data
		    ?meuse
		    class(meuse)
		    head(meuse)
		    plot(meuse)
		    meuse.sp <- meuse
		    coordinates(meuse.sp)<- ~x+y
		    class(meuse.sp)
		    str(meuse.sp)
		    plot(meuse.sp)
        

  ##----------------------------------------------------------------------------
  # III. Iterating Opperations -- There are always several ways to do the same thing...
    # A. Loops
      # Pros: easier to debug
      # Cons: harder to adapt

      # Lets start simple. Say we have two vectors we want to combine...
      x <- runif(1000000)  # generates (pseudo)random points from a uniform dist.
      y <- runif(1e6)  # same call, using scietific notation

      length(x)

        # We could do this one by one, e.g.:
        z1 <- x[1]+y[1]
      
        # Loops let us iterate across a set of values...
        
        zi <- c() # Step 1: create empty vector (to store results)
        for(i in 1:length(x)){ # Step 2: fill element by element
        	zi[i] <- x[i] + y[i]
        }    
                

    # B. Vectorization
      # But in simple cases R is set up to take care of this for us.
      # We can get the same answer as zi from just:
      z <- x + y
      length(z) == length(zi)  # inputs and output are same length
      all(z==zi) # check: each value from "z" equals its counterpart in "zi"?
        
      # Let's compare the efficiency of these methods by timing them...
      system.time(z <- x + y) # almost too small to measure
        
      zi <- c()
      system.time(  
        for(i in 1:length(x)){
      	  zi[i] <- x[i] + y[i]
        }
      )
    
      # What explains this difference?


      # Other Pros/Cons?

    
    # C. *apply
      # "apply" funcitons allow vecotrization across a variety of objects
      # Pros: easier to adapt, simpler, faster
      # Cons: harder to learn/debug  
      # Using the "*apply" family often requires writing our own functions    

      # we used this earlier when we wanted the class of each element in "list1"
      classes.list1 <- lapply(list1, class)  # lapply for lists
      classes.list1  # keeps any names
      class(classes.list1)
      str(classes.list1)
        # instead of, e.g. with a for loop:
          classes.list1b <- c()
          for(i in 1:length(list1)){
          	classes.list1b[i] <- class(list1[[i]])
          } # notice: names not retained-- that'd take an extra line of code!

      # let's say we wanted mean "zinc" concentration by land use: 
      head(meuse)            
      tapply(meuse$zinc, meuse$landuse, mean) # tapply for grouping data
      
      # or every metal concentration by land use:
      metals <-   c("cadmium", "copper", "lead", "zinc")  
      sapply(metals, function(x){  # sapply for "simplifying" results
      	tapply(meuse[, x], meuse$landuse, mean)
      })
      
      # now let's try to recreate this without using *apply... ugh
      landuse <- levels(meuse$landuse)
      mean.ppm <- matrix(
        nrow = length(landuse),
        ncol = length(metals),
        dimnames = list(landuse, metals)
      )      
      for (i in 1:length(landuse)){
        for (j in 1:length(metals)){
      	  mean.ppm[i, j] <- mean(meuse[which(meuse$landuse==landuse[i]),
      	    metals[j]]) 
        }
      }
      
      # If we want to know total metal ppm:
      apply(meuse[, metals], 1, sum)  # apply for operating by row (1) or column (2)
     
     
     # *apply summary
       #  lapply: across lists
       #  apply: across rows or columns
       #  sapply: to name or simplify results (simplification can also cause trouble...)
       #  tapply (or "by"): to group data
       #  mapply: for multiple inputs

      
