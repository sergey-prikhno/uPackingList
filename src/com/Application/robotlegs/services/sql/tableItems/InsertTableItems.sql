INSERT INTO main.categories
(
	parentId,
	isChild,
	label,
	isPacked,
	orderIndex,
	item_id	
)
VALUES
(
	:parentId,
	:isChild,
	:label,
	:isPacked,
	:orderIndex,
	:item_id	
)