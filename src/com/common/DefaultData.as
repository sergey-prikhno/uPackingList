package com.common {
	import com.Application.robotlegs.model.vo.VOPackedItem;

	public class DefaultData {
		
		
		/// DEFAULT SETTINGS
		public static const LANGUAGE:String = "English";
		public static const WELCOME:String = "1";
		public static const THEME:String = "1";		
		
		
		public static const CATEGORIES:Vector.<VOPackedItem> = new Vector.<VOPackedItem>;
		
		//parent
		CATEGORIES.push(new VOPackedItem("Preparations",1));
		CATEGORIES.push(new VOPackedItem("Accessories",2));
		CATEGORIES.push(new VOPackedItem("Hygiene",3));
		CATEGORIES.push(new VOPackedItem("Health",4));
		CATEGORIES.push(new VOPackedItem("Hats",5));
		CATEGORIES.push(new VOPackedItem("Money",6));
		CATEGORIES.push(new VOPackedItem("Children's accessories",7));
		CATEGORIES.push(new VOPackedItem("Documents",8));
		CATEGORIES.push(new VOPackedItem("Shoes",9));
		CATEGORIES.push(new VOPackedItem("Clothes",10));
		CATEGORIES.push(new VOPackedItem("Tableware",11));
		CATEGORIES.push(new VOPackedItem("Food",12));
		CATEGORIES.push(new VOPackedItem("Sport",13));
		CATEGORIES.push(new VOPackedItem("Luggage",14));
		CATEGORIES.push(new VOPackedItem("Gadgets",15));
		CATEGORIES.push(new VOPackedItem("Before leaving",16));
		
		//children
		//1
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 1",0,1,true));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 2",0,1,true));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 3",0,1,true));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 4",0,1,true));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 5",0,1,true));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 6",0,1,true));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 7",0,1,true));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 8",0,1,true));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 9",0,1,true));
		CATEGORIES.push(new VOPackedItem("Preparations Sub Item 10",0,1,true));
		
		
		//2
		CATEGORIES.push(new VOPackedItem("Accessories Sub Item 1",0,2,true));
		CATEGORIES.push(new VOPackedItem("Accessories Sub Item 2",0,2,true));
		CATEGORIES.push(new VOPackedItem("Accessories Sub Item 3",0,2,true));
		CATEGORIES.push(new VOPackedItem("Accessories Sub Item 4",0,2,true));
		
		
		//3
		CATEGORIES.push(new VOPackedItem("Hygiene Sub Item 1",0,3,true));
		CATEGORIES.push(new VOPackedItem("Hygiene Sub Item 2",0,3,true));
		CATEGORIES.push(new VOPackedItem("Hygiene Sub Item 3",0,3,true));
		CATEGORIES.push(new VOPackedItem("Hygiene Sub Item 4",0,3,true));

		//4
		CATEGORIES.push(new VOPackedItem("Health Sub Item 1",0,4,true));
		CATEGORIES.push(new VOPackedItem("Health Sub Item 2",0,4,true));
		
		//5
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 1",0,5,true));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 2",0,5,true));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 3",0,5,true));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 4",0,5,true));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 5",0,5,true));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 6",0,5,true));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 7",0,5,true));
		CATEGORIES.push(new VOPackedItem("Hats Sub Item 8",0,5,true));
		
		
		//6
		CATEGORIES.push(new VOPackedItem("Money Sub Item 1",0,6,true));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 2",0,6,true));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 3",0,6,true));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 4",0,6,true));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 5",0,6,true));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 6",0,6,true));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 7",0,6,true));
		CATEGORIES.push(new VOPackedItem("Money Sub Item 8",0,6,true));
		
		//7
		CATEGORIES.push(new VOPackedItem("Children's accessories Sub Item 1",0,7,true));
				
		//8
		CATEGORIES.push(new VOPackedItem("Documents Sub Item 1",0,8,true));
		CATEGORIES.push(new VOPackedItem("Documents Sub Item 2",0,8,true));
		CATEGORIES.push(new VOPackedItem("Documents Sub Item 3",0,8,true));
				
		//9
		CATEGORIES.push(new VOPackedItem("Shoes Sub Item 1",0,9,true));
		CATEGORIES.push(new VOPackedItem("Shoes Sub Item 2",0,9,true));
		CATEGORIES.push(new VOPackedItem("Shoes Sub Item 3",0,9,true));
		CATEGORIES.push(new VOPackedItem("Shoes Sub Item 4",0,9,true));
		CATEGORIES.push(new VOPackedItem("Shoes Sub Item 5",0,9,true));
		
		
		//10
		CATEGORIES.push(new VOPackedItem("Clothes Sub Item 1",0,10,true));
		CATEGORIES.push(new VOPackedItem("Clothes Sub Item 2",0,10,true));
		CATEGORIES.push(new VOPackedItem("Clothes Sub Item 3",0,10,true));
		
		//11
		CATEGORIES.push(new VOPackedItem("Tableware Sub Item 1",0,11,true));
		CATEGORIES.push(new VOPackedItem("Tableware Sub Item 2",0,11,true));
		CATEGORIES.push(new VOPackedItem("Tableware Sub Item 3",0,11,true));
		
		//12
		CATEGORIES.push(new VOPackedItem("Food Sub Item 1",0,12,true));
		CATEGORIES.push(new VOPackedItem("Food Sub Item 2",0,12,true));
		CATEGORIES.push(new VOPackedItem("Food Sub Item 3",0,12,true));
		
		//13
		CATEGORIES.push(new VOPackedItem("Sport Sub Item 1",0,13,true));
		CATEGORIES.push(new VOPackedItem("Sport Sub Item 2",0,13,true));
		CATEGORIES.push(new VOPackedItem("Sport Sub Item 3",0,13,true));
		
		//14
		CATEGORIES.push(new VOPackedItem("Luggage Sub Item 1",0,14,true));
		CATEGORIES.push(new VOPackedItem("Luggage Sub Item 2",0,14,true));
		CATEGORIES.push(new VOPackedItem("Luggage Sub Item 3",0,14,true));
		
		//15
		CATEGORIES.push(new VOPackedItem("Gadgets Sub Item 1",0,15,true));
		CATEGORIES.push(new VOPackedItem("Gadgets Sub Item 2",0,15,true));
		CATEGORIES.push(new VOPackedItem("Gadgets Sub Item 3",0,15,true));
		
		//16
		CATEGORIES.push(new VOPackedItem("Before leaving Sub Item 1",0,16,true));
		CATEGORIES.push(new VOPackedItem("Before leaving Sub Item 2",0,16,true));
		CATEGORIES.push(new VOPackedItem("Before leaving Sub Item 3",0,16,true));
	}
}