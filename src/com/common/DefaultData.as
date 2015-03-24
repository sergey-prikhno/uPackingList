package com.common {
	import com.Application.robotlegs.model.vo.VOPackedItem;

	public class DefaultData {
		
		
		/// DEFAULT SETTINGS
		public static const LANGUAGE:String = "English";
		public static const WELCOME:String = "1";
		public static const THEME:String = "1";		
		
		//SQL Statement
		//create Table
		public static const TABLE_SEPARATOR:String = "TABLE_SEPARATOR";
		
		public static const CREATE_CATEGORY_TABLE_1:String = " CREATE TABLE main.";		
		public static const CREATE_CATEGORY_TABLE_2:String = " (id int PRIMARY KEY AUTOINCREMENT, parentId int,isChild String,label String,isPacked String, orderIndex int, item_id int)";
		
		//insert row
		public static const INSERT_CATEGORY_TABLE_1:String = " INSERT INTO main.";		
		public static const INSERT_CATEGORY_TABLE_2:String = " (parentId,isChild,label,isPacked,orderIndex,item_id) VALUES (:parentId,:isChild,:label,:isPacked,:orderIndex,:item_id) ";
		
		//update row
		public static const UPDATE_CATEGORY_TABLE_1:String = " UPDATE main.";		
		public static const UPDATE_CATEGORY_TABLE_2:String = " SET parentId = :parentId, isChild = :isChild, label = :label, isPacked = :isPacked, orderIndex = :orderIndex, item_id = :item_id WHERE  id = :id";
		
		//Select 		
		public static const SELECT_CATEGORY_TABLE_1:String = " SELECT id,parentId,isChild,label,isPacked,orderIndex,item_id FROM main.";		
		public static const SELECT_CATEGORY_TABLE_2:String = " ORDER BY orderIndex";
		
		public static const SELECT_COPY_TABLE_1:String = " SELECT id,parentId,isChild,label,isPacked,orderIndex,item_id FROM main.";		
		public static const SELECT_COPY_TABLE_2:String = " ORDER BY id";
		
		//Delete 		
		public static const DELETE_CATEGORY_TABLE_1:String = " DELETE FROM main.";		
		public static const DELETE_CATEGORY_TABLE_2:String = " WHERE id = :id";
		
		
		
		public static const CATEGORIES:Vector.<VOPackedItem> = new Vector.<VOPackedItem>;
		
		//parent
		CATEGORIES.push(new VOPackedItem("Preparations",1,0,false,1,1));
		CATEGORIES.push(new VOPackedItem("Accessories",2,0,false,2,2));
		CATEGORIES.push(new VOPackedItem("Hygiene",3,0,false,3,3));
		CATEGORIES.push(new VOPackedItem("Health",4,0,false,4,4));
		CATEGORIES.push(new VOPackedItem("Hats",5,0,false,5,5));
		CATEGORIES.push(new VOPackedItem("Money",6,0,false,6,6));
		CATEGORIES.push(new VOPackedItem("Children's accessories",7,0,false,7,7));
		CATEGORIES.push(new VOPackedItem("Documents",8,0,false,8,8));
		CATEGORIES.push(new VOPackedItem("Shoes",9,0,false,9,9));
		CATEGORIES.push(new VOPackedItem("Clothes",10,0,false,10,10));
		CATEGORIES.push(new VOPackedItem("Tableware",11,0,false,11,11));
		CATEGORIES.push(new VOPackedItem("Food",12,0,false,12,12));
		CATEGORIES.push(new VOPackedItem("Sport",13,0,false,13,13));
		CATEGORIES.push(new VOPackedItem("Luggage",14,0,false,14,14));
		CATEGORIES.push(new VOPackedItem("Gadgets",15,0,false,15,15));
		CATEGORIES.push(new VOPackedItem("Before leaving",16,0,false,16,16));
		
		//children
		//1
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 1",0,1,true,1));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 2",0,1,true,2));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 3",0,1,true,3));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 4",0,1,true,4));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 5",0,1,true,5));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 6",0,1,true,6));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 7",0,1,true,7));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 8",0,1,true,8));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 9",0,1,true,9));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 10",0,1,true,10));
		
		
		//2
		CATEGORIES.push(new VOPackedItem("Accessories Sub Item 1",0,2,true,1));
		CATEGORIES.push(new VOPackedItem("Accessories Sub Item 2",0,2,true,2));
		CATEGORIES.push(new VOPackedItem("Accessories Sub Item 3",0,2,true,3));
		CATEGORIES.push(new VOPackedItem("Accessories Sub Item 4",0,2,true,4));
		
		
		//3
		CATEGORIES.push(new VOPackedItem("Hygiene Sub Item 1",0,3,true,1));
		CATEGORIES.push(new VOPackedItem("Hygiene Sub Item 2",0,3,true,2));
		CATEGORIES.push(new VOPackedItem("Hygiene Sub Item 3",0,3,true,3));
		CATEGORIES.push(new VOPackedItem("Hygiene Sub Item 4",0,3,true,4));

		//4
		CATEGORIES.push(new VOPackedItem("Health Sub Item 1",0,4,true,1));
		CATEGORIES.push(new VOPackedItem("Health Sub Item 2",0,4,true,2));
		
		//5
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 1",0,5,true,1));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 2",0,5,true,2));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 3",0,5,true,3));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 4",0,5,true,4));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 5",0,5,true,5));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 6",0,5,true,6));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 7",0,5,true,7));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 8",0,5,true,8));
		
		
		//6
		CATEGORIES.push(new VOPackedItem("Money Sub Item 1",0,6,true,1));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 2",0,6,true,2));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 3",0,6,true,3));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 4",0,6,true,4));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 5",0,6,true,5));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 6",0,6,true,6));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 7",0,6,true,7));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 8",0,6,true,8));
		
		//7
		CATEGORIES.push(new VOPackedItem("Children's accessories Sub Item 1",0,7,true,1));
				
		//8
		CATEGORIES.push(new VOPackedItem("Documents Sub Item 1",0,8,true,1));
		CATEGORIES.push(new VOPackedItem("Documents Sub Item 2",0,8,true,2));
		CATEGORIES.push(new VOPackedItem("Documents Sub Item 3",0,8,true,3));
				
		//9
		CATEGORIES.push(new VOPackedItem("Shoes Sub Item 1",0,9,true,1));
		CATEGORIES.push(new VOPackedItem("Shoes Sub Item 2",0,9,true,2));
		CATEGORIES.push(new VOPackedItem("Shoes Sub Item 3",0,9,true,3));
		CATEGORIES.push(new VOPackedItem("Shoes Sub Item 4",0,9,true,4));
		CATEGORIES.push(new VOPackedItem("Shoes Sub Item 5",0,9,true,5));
		
		
		//10
		CATEGORIES.push(new VOPackedItem("Clothes Sub Item 1",0,10,true,1));
		CATEGORIES.push(new VOPackedItem("Clothes Sub Item 2",0,10,true,2));
		CATEGORIES.push(new VOPackedItem("Clothes Sub Item 3",0,10,true,3));
		
		//11
		CATEGORIES.push(new VOPackedItem("Tableware Sub Item 1",0,11,true,1));
		CATEGORIES.push(new VOPackedItem("Tableware Sub Item 2",0,11,true,2));
		CATEGORIES.push(new VOPackedItem("Tableware Sub Item 3",0,11,true,3));
		
		//12
		CATEGORIES.push(new VOPackedItem("Food Sub Item 1",0,12,true,1));
		CATEGORIES.push(new VOPackedItem("Food Sub Item 2",0,12,true,2));
		CATEGORIES.push(new VOPackedItem("Food Sub Item 3",0,12,true,3));
		
		//13
		CATEGORIES.push(new VOPackedItem("Sport Sub Item 1",0,13,true,1));
		CATEGORIES.push(new VOPackedItem("Sport Sub Item 2",0,13,true,2));
		CATEGORIES.push(new VOPackedItem("Sport Sub Item 3",0,13,true,3));
		
		//14
		CATEGORIES.push(new VOPackedItem("Luggage Sub Item 1",0,14,true,1));
		CATEGORIES.push(new VOPackedItem("Luggage Sub Item 2",0,14,true,2));
		CATEGORIES.push(new VOPackedItem("Luggage Sub Item 3",0,14,true,3));
		
		//15
		CATEGORIES.push(new VOPackedItem("Gadgets Sub Item 1",0,15,true,1));
		CATEGORIES.push(new VOPackedItem("Gadgets Sub Item 2",0,15,true,2));
		CATEGORIES.push(new VOPackedItem("Gadgets Sub Item 3",0,15,true,3));
		
		//16
		CATEGORIES.push(new VOPackedItem("Before leaving Sub Item 1",0,16,true,1));
		CATEGORIES.push(new VOPackedItem("Before leaving Sub Item 2",0,16,true,2));
		CATEGORIES.push(new VOPackedItem("Before leaving Sub Item 3",0,16,true,3));
	}
}