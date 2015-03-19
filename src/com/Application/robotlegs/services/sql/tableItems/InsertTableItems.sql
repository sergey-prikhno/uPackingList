INSERT INTO main.categories
(
	parentId,
	isChild,
	label,
	isPacked	
)
VALUES
(
	:parentId,
	:isChild,
	:label,
	:isPacked	
)