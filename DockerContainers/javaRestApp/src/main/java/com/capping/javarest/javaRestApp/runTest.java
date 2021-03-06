package com.capping.javarest.javaRestApp;
import java.sql.*;
import java.util.ArrayList;

public class runTest 
{
	
	
	public static ArrayList<String> runTest(String sickUser) throws SQLException, ClassNotFoundException {
		//Instantiate myTables, the ArrayList+ that will hold the values of each user in the database
		ArrayList<ArrayList<Users>> myTables = new ArrayList<ArrayList<Users>>();
		
		//Instantiate use, the ArrayList<String> that holds the hash values of all the users in the database
		ArrayList<String> use = new ArrayList<String>();
		
		//Instantiate myInf, the ArrayList<Users> that will hold the values of the specific sick user
		ArrayList<Users> myInf = new ArrayList<Users>();
		
		//Instantiate myCont, the ArrayList<Users> that holds all the users who are contaminated (were in contact with a sick user)
		ArrayList<Users> myCont = new ArrayList<Users>();
			
		//Call getUsers() to get an ArrayList of all the hash's in the database
		use = getUsers.getUsers();
		
		//Call getData to create an ArrayList+ using the hash values collected by getUsers
		myTables= getData.getData(use);
		
		//Search for the sick user's data and load it into an ArrayList
		myInf = searchDB.searchDB(sickUser);
		
		//Determine the contaminated users using the full database and the infected user's data
		myCont= getContam.getContam(myTables, myInf);
		updateContam.updateContam(myCont);

		//Create an ArrayList<String> to hold the hashes
		ArrayList<String> hashes = new ArrayList<String>();

		//Go through the list of contaminated users and record the hash values
		for(int x=0; x < myCont.size(); x++){
			hashes.add(myCont.get(x).getHash());
		}

		//Print the hashes for testing
		System.out.println(hashes);

		//Indicate the test ran successfully in console
		System.out.println("Complete");

		//Return the list of hashes
		return hashes;
	}
}