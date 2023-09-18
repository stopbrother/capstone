create table RECEIPE (
	foodNum int,
    foodName varchar(50),
    foodIngre varchar(1000),
    foodImg varchar(50),
    recipeImg varchar(2048),
    primary key(foodNum)
);

insert into RECEIPE values (1,'콩나물국밥','콩나물(2줌=160g),대파(10cm),밥(2공기),송송 썬 고추(1개),
							국물용멸치(10마리),다시마(1장=10x10cm),새우젓(1),다진마늘(0.5),소금,고춧가루,부순참깨',
                            'food1.jpg','recipe1-1.jpg,recipe1-2.jpg,recipe1-3.jpg,
                            recipe1-4.jpg,recipe1-5.jpg,recipe1-6.jpg');
insert into RECEIPE values (2,'두부채소카레','다진 쇠고기(½컵),양파(½개), 두부(½모),브로콜리(¼송이), 파프리카(¼개),카레가루(3)',
							'두부채소카레.jpg','두부채소카레01.jpg,두부채소카레02.jpg,두부채소카레03.jpg,두부채소카레04.jpg,
                            두부채소카레05.jpg');