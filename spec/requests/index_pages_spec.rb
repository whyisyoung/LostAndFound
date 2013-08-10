require 'spec_helper'

describe "Index Pages" do
  
  describe "Home page" do
  	
  	it "should have the content 'Lost and Found'" do
  		visit '/index_pages/home'
  		expect(page).to have_content( 'Lost and Found' )
  	end

  	it "should have the title 'Home'" do
  		visit '/index_pages/home'
  		expect(page).to have_title( "Lost and Found | Home" )
  	end
  end

  describe "Help page" do
  	
  	it "should have the content 'Help'" do
  		visit '/index_pages/help'
  		expect(page).to have_content( 'Help' )
  	end

  	it "should have the title 'Help'" do
  		visit '/index_pages/help'
  		expect(page).to have_title( "Lost and Found | Help" )
  	end
  end

  describe "About page" do
  	
  	it "should have the content 'About Us'" do
  		visit '/index_pages/about'
  		expect(page).to have_content( 'About Us' )
  	end

  	it "should have the title 'About Us'" do
  		visit '/index_pages/about'
  		expect(page).to have_title( "Lost and Found | About Us" )
  	end
  end

  describe "Contact page" do
  	
  	it "should have the content 'Contact'" do
  		visit '/index_pages/contact'
  		expect(page).to have_content( 'Contact' )
  	end

  	it "should have the title 'Contact'" do
  		visit '/index_pages/contact'
  		expect(page).to have_title( "Lost and Found | Contact" )
  	end
  end
end
