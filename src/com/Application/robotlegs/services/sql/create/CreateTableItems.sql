CREATE TABLE main.categories
(
	id int PRIMARY KEY AUTOINCREMENT,
	parentId int,
	isChild String,
	label String		
)