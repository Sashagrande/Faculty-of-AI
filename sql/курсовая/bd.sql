DROP DATABASE IF EXISTS bd_rpg_game;
CREATE DATABASE bd_rpg_game;
USE bd_rpg_game;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	login varchar(50) NOT NULL UNIQUE,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
 	password_hash VARCHAR(100) NOT NULL,
	birthday DATE,
	created_at DATETIME DEFAULT NOW(),
	balance FLOAT COMMENT 'баланс донатных денег в игре',
	is_banned BIT DEFAULT 0 COMMENT 'для бана профиля',
	
    INDEX users_login_idx(login)
) COMMENT 'профили игроков';


DROP TABLE IF EXISTS pers;
CREATE TABLE pers (
	pers_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL, 
	name VARCHAR(50) NOT NULL UNIQUE,
	lvl TINYINT UNSIGNED NOT NULL COMMENT 'уровень персонажа',
	hp FLOAT UNSIGNED NOT NULL COMMENT 'количество здоровья персонажа',
	carry_weight FLOAT UNSIGNED NOT NULL COMMENT 'переносимый вес в рюкзаке',
	slots TINYINT UNSIGNED NOT NULL COMMENT 'количество слотов в рюкзаке',
	endurance FLOAT UNSIGNED NOT NULL COMMENT 'выносливость персонажа',
	balance BIGINT UNSIGNED DEFAULT 1500 COMMENT 'баналс игровой валюты',
	accuracy FLOAT UNSIGNED NOT NULL COMMENT 'меткость',
	
	FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT 'персонажи игроков';

   
DROP TABLE IF EXISTS loot_categories;   
CREATE TABLE loot_categories (
	cat_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL COMMENT 'оружие, еда, боеприпасы и тд'

) COMMENT 'категории лута';


DROP TABLE IF EXISTS loot;
CREATE TABLE loot(
	loot_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	category INT UNSIGNED NOT NULL,
	description TEXT,
	weight FLOAT UNSIGNED NOT NULL,
	price FLOAT UNSIGNED NOT NULL,
	donate_price FLOAT UNSIGNED,
	slots TINYINT UNSIGNED NOT NULL COMMENT 'количество занимемых слотов в рюкзаке',
	is_donated BIT DEFAULT 0,
	
	FOREIGN KEY (category) REFERENCES loot_categories(cat_id)
	
) COMMENT 'весь лут который есть в игре';


DROP TABLE IF EXISTS backpack;
CREATE TABLE backpack(
	backp_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	pers_id BIGINT UNSIGNED NOT NULL,
	loot_id INT UNSIGNED NOT NULL,
	quantity INT UNSIGNED NOT NULL COMMENT 'количество в рюкзаке',
	state FLOAT(5,2) UNSIGNED NOT NULL COMMENT 'состояние вещи 100% максимум',
	mod1 INT UNSIGNED COMMENT 'дополнения к вещам, например моды для оружия или для одежды',
	mod2 INT UNSIGNED,
	
	FOREIGN KEY (pers_id) REFERENCES pers(pers_id),
	FOREIGN KEY (loot_id) REFERENCES loot(loot_id),
	check (mod1 <> mod2)
) COMMENT 'рюкзак';


DROP TABLE IF EXISTS guns;
CREATE TABLE guns(
	gun_id INT UNSIGNED NOT NULL,
	class ENUM('steel arms', 'pistol', 'shotgun', 'submachine gun', 'rifle', 'carbine', 'machine gun'),
	damage FLOAT UNSIGNED NOT NULL,
	caliber ENUM('.577', '.50', '.45', '9 мм', '7,62 мм', '.22 LR', '5,56 мм', '5,45 мм', '12'),
	gun_lvl TINYINT UNSIGNED NOT NULL COMMENT 'уровень игрока, с которого доступно оружие',
	skin ENUM('1', '2', '3', '4'),
	accuracy FLOAT UNSIGNED NOT NULL COMMENT 'меткость',
	FOREIGN KEY (gun_id) REFERENCES loot(loot_id)

) COMMENT 'оружие';


DROP TABLE IF EXISTS mods_for_guns;
CREATE TABLE mods_for_guns(
	mod_g_id INT UNSIGNED NOT NULL,
	class_gun ENUM('steel arms', 'pistol', 'shotgun', 'submachine gun', 'rifle', 'carbine', 'machine gun'),
	class_g_mod ENUM('aim', 'muffler', 'stabilizer'),
	FOREIGN KEY (mod_g_id) REFERENCES loot(loot_id)
) COMMENT 'Модификаторы для оружия';

DROP TABLE IF EXISTS clothes;
CREATE TABLE clothes(
	clothes_id INT UNSIGNED NOT NULL,
	cloth_class ENUM('headdress', 'jacket', 'pants', 'shoes'),
	cloth_lvl TINYINT UNSIGNED NOT NULL,
	protection FLOAT UNSIGNED NOT NULL COMMENT 'коэф защиты',
	FOREIGN KEY (clothes_id) REFERENCES loot(loot_id)
) COMMENT 'Одежда';


DROP TABLE IF EXISTS mod_for_clothes;
CREATE TABLE mod_for_clothes(
	mod_cl_id INT UNSIGNED NOT NULL,
	cloth_class ENUM('headdress', 'jacket', 'pants', 'shoes'),
	protection FLOAT UNSIGNED NOT NULL COMMENT 'коэф защиты',
	FOREIGN KEY (mod_cl_id) REFERENCES loot(loot_id)
) COMMENT 'Моды для одежды';


DROP TABLE IF EXISTS ammunition;
CREATE TABLE ammunition(
	ammo_id INT UNSIGNED NOT NULL,
	damage FLOAT UNSIGNED NOT NULL,
	armor_piercing FLOAT UNSIGNED NOT NULL COMMENT 'бронебойность',
	caliber ENUM('.577', '.50', '.45', '9 мм', '7,62 мм', '.22 LR', '5,56 мм', '5,45 мм', '12'),
	FOREIGN KEY (ammo_id) REFERENCES loot(loot_id)
) COMMENT 'боеприпасы';

DROP TABLE IF EXISTS NPC;
CREATE TABLE NPC(
	npc_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	lvl TINYINT UNSIGNED NOT NULL COMMENT 'уровень npc',
	hp FLOAT UNSIGNED NOT NULL COMMENT 'количество здоровья npc',
	damage FLOAT UNSIGNED NOT NULL, 
	loot VARCHAR(30) COMMENT 'при убийстве npc idшники лута будут генерироваться автоматически, и этот лут можно будет забрать себе'
);

DROP TABLE IF EXISTS quests;
CREATE TABLE quests(
	quest_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	description TEXT,
	name VARCHAR(50) NOT NULL,
	reward_money FLOAT UNSIGNED NOT NULL,
	reward_loot VARCHAR(30),
	quest_lvl TINYINT UNSIGNED NOT NULL
);


DROP TABLE IF EXISTS quest_pers;
CREATE TABLE quest_pers(
	pers_id BIGINT UNSIGNED NOT NULL,
	quest_id INT UNSIGNED NOT NULL,
	status BIT DEFAULT 0 comment 'если 0 - квест не выполнен, если 1 - выполнен',
	FOREIGN KEY (pers_id) REFERENCES pers(pers_id),
	FOREIGN KEY (quest_id) REFERENCES quests(quest_id)
) COMMENT 'Список квестов у персонажей';


DROP TABLE IF EXISTS food;
CREATE TABLE food(
	food_id INT UNSIGNED NOT NULL,
	hp FLOAT COMMENT 'динамика здоровья если съесть',
	endurance FLOAT COMMENT 'динамика выносливости если съесть',
	FOREIGN KEY (food_id) REFERENCES loot(loot_id)
);



INSERT INTO `users` VALUES ('1','Mr. Dewayne Bogisich','Billy','Willms','yasmeen.wehner@example.com','ce73637f67e15e27f322497a9be2e7ac910fdbb4','1989-02-01','1978-09-16 23:50:40',NULL,0),
('2','Helen Gleason','Mekhi','Padberg','melisa76@example.com','79615b5453e75dba29cecc261410aa42ca9f536b','2014-06-05','2018-02-02 09:07:18',NULL,0),
('3','Eliza Roberts','Consuelo','Ankunding','skonopelski@example.org','ffffb4cf0910958b4ed1141b1e1a611b7d3bb006','2018-10-05','2008-05-15 13:45:30',NULL,0),
('4','Osbaldo Hudson I','Vesta','McKenzie','mabelle90@example.com','d72a0510daf38fb1b3cf1ca2d7e3109d85eb6aa1','1980-10-06','2014-12-15 05:29:36',NULL,0),
('5','Kristin Purdy','Lambert','Bode','lisette85@example.com','c7d41522b0ce53360366bc531e18b2058ae47611','2015-06-20','1978-08-17 11:43:42',NULL,0),
('6','Rebeca Schaden','Ida','Cruickshank','sfritsch@example.com','7271db2c1561c10a195bcb07b6ab66ff66ea659a','1986-11-05','1974-02-11 09:43:23',NULL,0),
('7','Dr. Harry Quitzon','Gia','Satterfield','antone36@example.net','f5b1495a7ce1e1116fe9fd2e4af14d62c7da8441','1984-12-14','1994-06-16 01:16:53',NULL,0),
('8','Mrs. Juanita Champlin','Tristian','Reichel','morris63@example.net','db98c313933dee87940c97c8ec556633a9d95d3a','2000-09-10','2006-01-28 04:47:56',NULL,0),
('9','Ms. Kiarra Lowe PhD','Arvel','Mitchell','stehr.dee@example.com','b12d17ac078291461cbd07c4adc615dea131ada6','2013-04-20','2020-12-01 17:51:11',NULL,0),
('10','Layne Lehner','Burnice','Kutch','erunte@example.com','cfac7451be334d5d3abb456671245c9f656b58bd','1982-07-13','1996-10-09 00:36:23',NULL,0),
('11','Raleigh Kunde II','Alden','Purdy','dianna84@example.com','5bc6ed4d449805eea69d0d80b1f785fd1a1e206f','2011-08-06','1990-09-06 18:48:14',NULL,0),
('12','Flossie Mills','Violet','Smitham','wuckert.isaac@example.net','06bb19f4ea7e6dd1e8e5f3a26f2773252df26618','2017-11-29','1985-03-10 09:21:53',NULL,0),
('13','Dr. Cullen Hickle','Tiffany','Botsford','steuber.bernita@example.net','09c56a66bb18c4cfdd2516e4f8384ae45f7cef1f','1982-12-06','2001-10-22 02:29:38',NULL,0),
('14','Amie Hansen','Rodger','Bosco','jairo.ritchie@example.com','b09f56d263407456ef36d631dbb2adddbdc1f279','1970-02-03','1980-01-16 09:28:29',NULL,1),
('15','Prof. Garnet Reichert','Letha','Zulauf','qreinger@example.com','54a159b2903f4ba66143f3c7b6a9d03ed8b88727','2014-12-18','2009-04-09 06:11:46',NULL,0),
('16','Sibyl Miller','Colton','Kuhn','charlotte.sporer@example.org','d0015f9ee38174cc3f6be0f98328b6fee7d5468a','2002-07-02','1973-09-27 02:40:14',NULL,0),
('17','Paige Nicolas Sr.','Muriel','Kuhlman','blick.kristian@example.com','de2920740e549b2abc9532f1fa76b812714af1c1','1970-05-06','2019-03-29 22:05:39',NULL,0),
('18','Keira Fritsch','Kirsten','Schmidt','ubernhard@example.net','513dc084e8693709a3044506e705830e1b7b9af7','1982-01-18','2013-03-05 04:25:09',NULL,0),
('19','Pink Wintheiser','Shaun','Pagac','uturcotte@example.net','49b10d09f4764d13a49e2eb366a3802732fb479c','2016-09-04','1980-04-10 12:04:21',NULL,0),
('20','Mr. Chet Stiedemann','Kenton','Thiel','douglas.rashad@example.net','d7857d69d9758725dfdde7e70adc06e1f3271d6b','2008-03-09','1981-10-09 05:23:20',NULL,0); 




INSERT INTO `pers` VALUES ('1','1','quisquam','19','391.51','108.7','29','78.636','129818','42'),
('2','2','quia','1','1202.82','79.5195','10','67.9','257994','51'),
('3','3','occaecati','20','472.841','107.459','17','81.0362','195638','16'),
('4','4','voluptatibus','7','380.531','147.303','24','97.98','203269','95.45'),
('5','5','eos','2','1890.49','115.293','28','25.3993','372344','69.6'),
('6','6','aut','10','1092.09','84.2384','13','64.0514','391312','40.186'),
('7','7','qui','4','870.032','63','15','24.2','2521','73.5144'),
('8','8','voluptas','6','1562.32','144.2','17','19.8751','497412','60.574'),
('9','9','nulla','15','1812.92','145.925','27','18.5876','14010','45.574'),
('10','10','est','13','1117.9','107.071','10','89.915','485281','60.6743'),
('11','11','praesentium','6','1545.64','129.753','20','52.7367','271095','42'),
('12','12','consequatur','2','548.39','84.6569','25','73.5613','484082','76.5'),
('13','13','non','11','1569.09','63.2','30','24.5178','480991','15.0923'),
('14','14','laudantium','2','439','78.3','30','51.5808','141762','69.8'),
('15','15','illum','19','528.748','122.323','29','41.69','99125','93.1557'),
('16','16','porro','10','1844.16','88.4175','28','88.1325','96683','56.39'),
('17','17','ipsum','9','747.984','139.121','30','15.2592','127974','65.5015'),
('18','18','soluta','9','1926.02','53','13','47.9985','32797','36.109'),
('19','19','sequi','5','361.7','100.425','12','22.016','163344','93.88'),
('20','20','magni','5','1144.1','98.3466','17','32.6','419488','35'),
('21','1','minima','15','1657.66','99.2614','27','50.5421','30393','94.93'),
('22','2','et','4','544.225','119.18','27','39.5576','279246','52.5753'),
('23','3','omnis','15','1406.56','144.174','14','49.3738','52446','14.547'),
('24','4','in','15','1702.16','82.2145','25','24','290901','57.0729'),
('25','5','tempore','16','1157.37','147.2','10','77','40066','26.3'),
('26','6','repellat','13','612.511','120.684','27','14.8686','421775','60.5168'),
('27','7','necessitatibus','16','1800.3','83','29','14.579','288752','57.45'),
('28','8','cumque','8','1576.14','100.748','11','97.7886','236881','24.8698'),
('29','9','dolorem','1','1590.88','131','16','37.1339','351196','88.0066'),
('30','10','id','6','1624.57','75.45','10','25.0867','196204','75.7'); 



INSERT INTO `loot_categories` VALUES ('1','food'),
('2','guns'),
('3','clothes'),
('4','mod for gun'),
('5','mod for clothes'),
('6','other'); 

INSERT INTO `NPC` VALUES ('1','non','40','1208.27','104',NULL),
('2','nobis','45','8854.4','113.968',NULL),
('3','possimus','38','3634.45','154.553',NULL),
('4','eos','12','5941.36','171.336',NULL),
('5','eum','37','11777','124.9',NULL),
('6','voluptas','35','14263.3','239.267',NULL),
('7','similique','34','10355.4','29.17',NULL),
('8','pariatur','28','11178','254.3',NULL),
('9','blanditiis','37','13427.2','97.8926',NULL),
('10','voluptas','8','10502.8','206.416',NULL),
('11','omnis','12','529.995','69.4652',NULL),
('12','expedita','11','11147.1','20.3601',NULL),
('13','sunt','24','3355.07','283.75',NULL),
('14','id','3','12716.3','109.673',NULL),
('15','voluptatibus','28','12951','219',NULL),
('16','voluptas','26','9883.28','185.18',NULL),
('17','quae','44','3001.79','204.766',NULL),
('18','doloremque','34','3023','151.49',NULL),
('19','sed','2','2911.36','15.2294',NULL),
('20','sed','25','12104.6','9.85751',NULL); 

INSERT INTO `loot` VALUES ('101','dolorum','1','Aut nostrum optio eius aut rerum maiores eius. Modi aut et quis sed earum et aut. Dolore sed et necessitatibus qui. Minima omnis repellat ipsa vel quisquam quod cumque.','1.0207','2680.99','491.247','2',0),
('102','reprehenderit','5','Non voluptas id modi tempora culpa voluptatem omnis. Non qui id harum adipisci ad est.','13.8332','6710.25','1096','3',1),
('104','nihil','3','Unde aut velit rem est qui id. Assumenda quibusdam doloremque alias sunt dolores fuga. Earum et consequatur cumque aut corrupti nam ea. Quam debitis eveniet eveniet.','8.12332','6387','1394.6','1',0),
('105','eum','1','Sunt a voluptates temporibus accusantium laudantium veniam. Vero alias quaerat est consequatur qui aut. Aut ut quasi a quo reiciendis ipsam deleniti. Blanditiis eaque distinctio quaerat ad mollitia ea.','5.28931','7657.61','959.154','2',0),
('106','dolorem','2','Quia quam neque ipsa. Nam dolor rem ut ducimus dolores. Repellat eligendi culpa aut soluta et doloremque atque.','11.1437','13290.7','610.903','1',0),
('108','doloremque','5','Veritatis quisquam quia est veritatis rem beatae nostrum. Doloremque labore laudantium sunt. Quam enim sapiente adipisci repellendus excepturi velit iste.','4.58204','9488.92','71.9272','3',0),
('109','mollitia','2','Ea sed aut omnis a cupiditate exercitationem earum. Corrupti nam deserunt aliquam inventore ut. Laborum ipsum accusantium aut. Dolores vero reiciendis dolore aspernatur non.','1.6','12451.2','590.112','1',0),
('111','velit','3','Beatae saepe sed dolorem. Nihil sit ut tempora incidunt repellat vel.','2','14752.4','1789.92','2',0),
('112','delectus','4','Dolorem voluptatem at iure sint eos. Dolor facere sequi sapiente in consequatur distinctio. Minima sunt omnis voluptatem accusamus.','13.93','753.802','1589.68','3',0),
('113','voluptas','3','Ut nam fugiat non ipsam quibusdam. Facilis qui est quo. Dolorum odit eos asperiores repellat doloribus aut nobis. Consequatur qui alias laboriosam dicta sunt est.','1.24515','668.134','1542.4','1',0),
('115','quia','3','Tempora ut ab sed. Dolorem odit voluptatibus sed nihil fuga. Odio sed enim delectus a qui qui omnis.','1.26826','4081','1169.17','1',0),
('119','dignissimos','2','Autem et maxime atque minima quisquam fugiat quis. Facere sint quidem est reprehenderit ut et ex. Aperiam sit quisquam aliquid non tempora qui est id. Atque nulla consequatur facere nulla.','8.15','11139.3','1550.47','2',0),
('121','consequuntur','1','Dignissimos voluptatem sed at quo sint quos earum autem. Deserunt numquam consequatur provident animi sint aperiam ut.','11.434','3295.68','964.9','3',1),
('123','labore','5','Voluptatem enim rerum minima ut. Vitae est aut est voluptate.','2','2968.28','699','2',0),
('124','nostrum','2','Vero pariatur quisquam sunt maxime non. Qui ut ullam ut corporis voluptates. Distinctio porro nostrum blanditiis esse assumenda.','9.9','2047.43','1900.19','2',0),
('125','dolor','5','Voluptatem similique libero quibusdam et sint rem adipisci repellendus. Omnis debitis natus dolor eaque laborum unde. Delectus similique nesciunt ad numquam voluptas vel enim. Est dolore veritatis nostrum mollitia voluptatem ducimus sit quam.','14.1231','8612.52','914.61','3',0),
('126','quis','5','Sed sed magnam corrupti et fuga. Accusamus tempore labore reiciendis eos quae ea occaecati.','4.1702','3512.08','892','2',0),
('127','repellendus','3','Eum voluptatem labore ab. Veniam minus sed dolores unde. Itaque et sapiente fugit nam deleniti reprehenderit eum.','14.7797','3886.5','177','1',1),
('128','et','4','Sit asperiores sequi hic odio totam error in. Corrupti aliquam nisi ad. Sit velit explicabo sequi aut.','11.249','8245.2','1825.23','1',1),
('130','perferendis','2','Error aut ut voluptatum suscipit ducimus incidunt autem. Unde sequi sequi totam et praesentium. Eum quam ea non earum sunt minima qui. Doloribus et quia ea magni vero deleniti.','10.2493','11234.7','253.2','3',0),
('131','suscipit','5','Quibusdam odio officia amet et delectus qui. Animi aut nihil ipsa eveniet. Nihil non ut deleniti culpa iure. Facilis id necessitatibus aliquid laborum minima debitis est.','5.53396','7943.23','1084','1',0),
('132','ratione','6','Possimus assumenda et inventore vel. Sed sit et asperiores ut enim dolorum. Vero sit labore maxime ipsum dolores sequi. Non sit officia illum quisquam vel fugit architecto.','10.5382','11904','693.267','3',0),
('133','ipsam','6','Excepturi laudantium voluptatibus sint sit et error. Consectetur quia ipsa et nihil. Corrupti illo sed ut modi repellat.','13','13550.7','1154.59','1',0),
('134','sed','6','Est facilis nam ut quaerat. Cumque odio molestias odit rerum id temporibus voluptatum. Optio est recusandae mollitia delectus officia rerum ut.','8.295','3689','1620.45','1',0),
('135','aliquam','6','Aperiam veritatis aperiam atque incidunt aperiam. Unde totam repellat voluptatem atque quas optio. Id voluptas odit debitis atque fuga voluptas et voluptate. Quo sit distinctio dolore voluptatibus. Eius nihil debitis officia eius quis.','12.26','14636.7','689.562','3',1),
('140','id','3','Aperiam sunt magnam non corporis reprehenderit in dolor expedita. Quia corrupti ratione deleniti possimus aspernatur incidunt ipsa. Nam rerum eos quidem maxime velit et et.','4.91276','14757.3','1465.5','3',0),
('143','doloribus','1','Voluptatum iste natus maiores eaque. Culpa corporis aspernatur consequatur quis neque sint tempora ullam. Aut sed nostrum animi non laboriosam tempore quo repudiandae. Quia provident iste temporibus voluptatem et.','9.56638','9144.81','130','2',0),
('145','est','6','Velit aspernatur hic recusandae. Explicabo nulla fugiat sunt. Ipsum accusantium animi corrupti et fugiat. Eaque qui sed esse architecto minima.','8.28438','3326.87','1847.11','1',0),
('146','vel','6','Natus odit soluta maxime a necessitatibus explicabo accusantium corrupti. Esse magni pariatur eum quia. Quia iusto expedita fuga eum at ut ducimus. Est vero neque ducimus similique sed labore ipsum et.','2.43','942.604','520.4','2',0),
('148','porro','2','Aspernatur qui beatae est qui laborum doloremque. Iste rerum a distinctio asperiores. Alias sapiente velit sed ducimus quo. Sed ea qui vitae aut autem et et.','14.3499','1125','1482','3',0),
('149','qui','5','Ullam beatae sed mollitia ipsam. Voluptate et qui eaque maxime tenetur earum. Ea voluptatem odio ratione voluptatem.','9.66742','11454','976.722','2',1),
('150','placeat','3','Mollitia sint ipsam voluptates aut repellat. Ullam iusto necessitatibus unde nisi. Repellendus cupiditate qui eaque dicta. Aut quis dolores officia quia consectetur rerum tenetur excepturi. Quos autem laudantium placeat nihil.','9.1437','11014.5','464','2',0),
('151','sunt','5','Doloribus optio at aspernatur consequatur sequi repudiandae. Reiciendis beatae tempora provident nostrum. Occaecati unde aut modi commodi ut perspiciatis. Ullam magnam cum unde tenetur tempore atque.','13.241','1862.87','267.3','1',0),
('152','aut','3','Ut ipsam sequi possimus doloremque autem architecto nostrum dolor. Ut quia amet neque vel eius magni praesentium laboriosam. Itaque quos eveniet fugit dolores necessitatibus praesentium. Ab ex autem porro.','9.1587','11361.3','1362','1',0),
('155','soluta','6','Veritatis ad architecto qui ipsa voluptas sed. Et occaecati error et atque. Quia vero ex ab aliquam. Corrupti eum maxime voluptatem similique.','7.014','14836','297.673','1',1),
('157','temporibus','4','Aperiam reprehenderit id vero rerum. Aspernatur nemo assumenda totam ipsam. Repudiandae blanditiis minus mollitia qui et laboriosam voluptatem. Iure fugit aut quae quo.','4','1859.86','1456.86','3',0),
('160','voluptatem','2','Doloremque voluptatum perspiciatis repellat iste voluptatem. Facilis veritatis et assumenda. Odio laborum in quia consectetur. Labore est repudiandae voluptas vero quisquam soluta in. Voluptas qui magni voluptatum.','8.25579','3880','553.75','2',0),
('161','neque','4','Rerum autem similique unde sint rerum tenetur. Occaecati harum dolores nihil veritatis in. Deleniti veritatis similique aut quaerat ut. Enim aut cum eligendi temporibus. Id veritatis voluptatem et aut voluptatem et at.','4.36587','2465.1','1467.6','2',0),
('162','dolores','6','Alias facere consequatur quam aut voluptatibus. Natus eum eum animi ipsa quia minima.','12.6','12581.2','1032.9','1',1),
('163','fuga','4','Deserunt debitis repellat ducimus porro autem. Modi odio deleniti voluptatem velit voluptatum delectus. Eligendi nobis magnam aut totam tempore fugit.','12','3749.65','179.245','1',0),
('166','a','2','Dolores ullam temporibus dolor omnis nostrum eos. Quam et suscipit incidunt recusandae optio reiciendis eveniet necessitatibus. Quia sint atque magnam illo voluptatem aperiam. Tempore libero totam culpa autem iste est reprehenderit.','13.5108','7356','425.264','1',0),
('167','autem','4','Quasi natus veritatis veniam molestias possimus dolores similique. Non ut earum laboriosam eum eos commodi. Voluptate voluptatem voluptatibus totam dolorem molestiae ut. Maiores molestias et perspiciatis assumenda voluptas architecto.','1.75949','4138.62','1266.23','3',1),
('171','ipsa','1','Quia vero enim voluptas voluptatem. Aliquam nisi vel libero est vel harum mollitia. Ullam rerum pariatur suscipit voluptas.','7.40433','13042.9','704.801','1',0),
('174','perspiciatis','5','Pariatur in quis accusamus illo eum. Tenetur molestiae explicabo natus sint laboriosam omnis fugiat. Occaecati nobis dolores omnis.','3.63221','4382.84','408.941','3',0),
('177','unde','2','Et omnis quam consequatur praesentium aut quisquam. Qui quia et rerum non atque. Omnis ut consequatur voluptatem.','5.4969','7033.7','1611.58','1',0),
('179','deserunt','3','Laudantium ipsum voluptates est minus quis optio quaerat. Voluptas laboriosam repudiandae libero quas eaque. Deleniti cum ut pariatur est iste quidem omnis quia.','3.7484','778.849','263.759','2',0),
('185','at','4','Rem distinctio velit odit odit in sed vel. Pariatur iusto est adipisci. Provident autem harum tenetur et.','7','3307.97','1022.5','2',1),
('186','asperiores','4','Rerum corporis modi dolorem et. Quisquam facilis facilis nulla officiis autem. Odit consequatur aliquam sit non aut ut.','3','1709.9','1264.98','2',1),
('187','ea','3','Quia voluptatem rerum ut sint. Voluptatem occaecati fuga quidem rerum. Et quas qui nam.','9.67031','7710.15','1165.99','1',1),
('188','aliquid','3','Inventore rem commodi fugiat ullam enim. Iure rem sint expedita rerum. Consectetur quia praesentium consequatur et consequatur deleniti.','9.29','6340.69','169.538','2',0),
('189','nulla','3','Minus reiciendis quo est minima. Veniam soluta eligendi velit commodi maxime. Sed laboriosam excepturi quis occaecati quo.','5.263','2164.88','798.744','3',0),
('192','quo','6','Accusamus sapiente consequatur molestiae libero tenetur exercitationem. Iste facere in accusantium mollitia tenetur.','7.37479','5637.73','193.127','3',0),
('194','quasi','2','Accusantium fugit fugit enim autem voluptates dolorem fugiat. Corporis facilis velit libero temporibus repellendus. Incidunt dolore qui dolorem excepturi assumenda.','6.51836','1192.54','1866.62','1',1),
('195','rerum','4','Illum accusantium saepe labore eum consectetur voluptatem. Autem est error cumque vero tempore minima ducimus. Non ut ipsam eum velit. Voluptas error et aut quod et est. Voluptatibus nostrum nihil rem soluta amet tenetur.','13.378','13301','661.625','1',1),
('196','voluptates','3','Placeat nihil veritatis qui quia est animi. Ducimus qui tenetur magni provident. Laudantium qui sit amet rerum possimus repellendus velit.','4.4098','10264.2','1736.47','2',0),
('198','sint','2','Eum distinctio dolore ut incidunt error blanditiis. Facere voluptas molestiae architecto rerum corporis.','12.2727','116.553','1084.57','3',0),
('200','modi','4','Fugit omnis sit amet nobis. Qui quidem id hic qui est praesentium. Quo laborum cumque qui ipsam quibusdam a.','13.3842','2876.02','4.8116','2',0); 





INSERT INTO `guns` VALUES ('126','machine gun','1477.17','12','38','2','52.7'),
('121','pistol','1097.13','5,56 мм','20','1','39.7926'),
('124','steel arms','313.713','.577','37','3','15.7162'),
('125','shotgun','1466.38','5,56 мм','39','3','48.9479'),
('119','shotgun','803.886','.577','17','2','86.2539'),
('123','rifle','1028.99','.50','32','4','40.4333'); 



INSERT INTO `food` VALUES ('108','82.7881','57.186'),
('104','50.6','52.2384'),
('112','62.719','45.0059'),
('115','59.35','22.872'),
('109','7.63198','17.89'),
('101','28.3543','54.4504'),
('113','18.3007','95.9506'),
('111','88.6556','21.8828'),
('106','46.0661','30.363'),
('105','55.25','93.5553'),
('102','69.05','83.46'); 



INSERT INTO `clothes` VALUES ('151','jacket','4','268.7'),
('155','headdress','21','440.651'),
('140','pants','14','395.214'),
('157','pants','30','193.339'),
('143','shoes','27','14.7849'),
('152','pants','27','71.993'),
('149','jacket','31','176.3'),
('145','pants','12','178'),
('150','jacket','11','52.7094'),
('146','pants','39','155.168'); 

INSERT INTO `ammunition` VALUES ('171','228.43','11.2972','9 мм'),
('174','729.457','26.5582','.22 LR'),
('179','238.2','61.8263','7,62 мм'); 


INSERT INTO `mod_for_clothes` VALUES ('163','headdress','33.4361'),
('162','headdress','17.92'),
('166','headdress','76.3973'),
('157','shoes','27.7959'),
('160','headdress','65.7'),
('161','pants','72.4699'); 


INSERT INTO `mods_for_guns` VALUES ('134','pistol','stabilizer'),
('135','submachine gun','stabilizer'),
('127','machine gun','muffler'),
('126','submachine gun','muffler'),
('128','pistol','stabilizer'),
('131','carbine','muffler'),
('133','steel arms','muffler'); 


INSERT INTO `quests` VALUES ('1','Ducimus consequatur hic omnis. Et quam minima cum. Molestiae doloribus mollitia est architecto et. Dicta modi pariatur sapiente sed ab ea.','name2','9174.01',NULL,'5'),
('2','Architecto consequatur in culpa dolor. Vero sapiente dolorem voluptatem quam. Non ut laboriosam et qui cupiditate illo culpa.','name1','9070.02',NULL,'13'),
('3','Laboriosam tempora provident qui nihil voluptas placeat. Rerum et et labore sunt perferendis dolor laudantium. Dolorem fugiat blanditiis quia sint quis voluptatem voluptate.','name3','1958.19',NULL,'7'),
('4','Cupiditate consequatur occaecati perspiciatis deserunt facilis molestiae dolorem. Aliquam dolores pariatur ut quisquam. Labore doloribus nihil sed rerum laborum. Maxime labore voluptatibus et non omnis. Illum et qui eos a eligendi.','name4','6961.25',NULL,'3'),
('5','Facere suscipit id sunt rerum omnis eos velit id. Omnis similique nulla nemo porro quibusdam perferendis. Soluta ratione eius aut et nihil voluptatem voluptatum.','name5','2956.65',NULL,'1'),
('6','Quisquam exercitationem harum sapiente blanditiis. Et et consequatur accusamus recusandae quas.','name6','8869.76',NULL,'13'),
('7','Nisi voluptatum non et. Quibusdam doloremque consequatur dolores fuga occaecati earum. Eum temporibus sit nihil sit.','name7','2850.58',NULL,'1'),
('8','Veritatis dolores sed dignissimos reprehenderit. Mollitia quo repellendus ut voluptatem modi unde a. Quo quo dolorem tempore consectetur adipisci deserunt quasi.','name8','6383.06',NULL,'16'),
('9','Quia illo ut mollitia quos qui. Nam quod sed qui architecto excepturi. Rerum itaque tenetur unde facilis. Rerum recusandae nisi dolor.','name9','4756.35',NULL,'18'),
('10','Officiis repudiandae magni blanditiis reprehenderit et ut omnis. Sed commodi est quia et dolorem impedit suscipit. Qui quod qui et qui perspiciatis officiis. Possimus ea similique odio magnam impedit quis est.','name10','9401.15',NULL,'17'),
('11','Ea velit omnis incidunt. Molestiae et non sunt est possimus fugit quae.','name11','2633.15',NULL,'9'),
('12','Aliquam quis dolor non magni voluptas voluptatum sit maiores. Illum perferendis magnam dolores tempora et porro natus. Vel eligendi et nam nobis ut. Sed aliquam ut perspiciatis magnam natus.','name12','4070.12',NULL,'8'),
('13','Unde architecto iure qui. Nesciunt at ea fuga perspiciatis. A consequuntur amet est quod.','name13','3761.46',NULL,'17'),
('14','Omnis odio labore aut laborum eius omnis ea. Aut neque assumenda sunt atque quia sequi et sint. Consequuntur exercitationem laudantium cupiditate. Iusto facere voluptatum rem.','name14','3380.76',NULL,'11'),
('15','Nihil autem assumenda ullam perferendis saepe. Aut dignissimos assumenda laudantium dolor quae laboriosam eaque quia. Accusamus aut saepe dolorem ut ex est dignissimos est.','name15','7019.79',NULL,'8'),
('16','Rerum aut et id rerum alias. Ipsa inventore quasi qui repudiandae similique. Distinctio in at recusandae occaecati voluptatem qui in. Atque quis quos necessitatibus placeat possimus vel est. Facere facilis corrupti sequi accusantium.','name16','9738.61',NULL,'5'),
('17','Ipsum qui et id accusamus et adipisci est. Ut occaecati quia non provident cum aliquam. Voluptatum inventore quo ex enim minus molestiae. Eos porro dolores expedita et.','name17','9859.29',NULL,'15'),
('18','Harum voluptatum doloremque ea numquam libero perspiciatis. Incidunt perferendis expedita dolores placeat. Dolore explicabo aspernatur voluptatem sunt natus reiciendis aliquid.','name18','6794',NULL,'10'),
('19','Mollitia odio doloribus et quia est. Nulla dolor eveniet accusantium ad sed illum error. Aperiam iusto nam qui laboriosam est voluptatem hic omnis. Aut quaerat nemo in architecto et a.','name19','6842.54',NULL,'13'),
('20','Doloremque asperiores et veritatis maiores rerum modi autem. Quam harum consequatur velit distinctio quia fugiat dignissimos.','name20','6905.13',NULL,'10'),
('21','Doloremque est nihil possimus voluptatem possimus nam rerum. Harum iusto dolores maxime. Quasi autem nesciunt corrupti dolores rerum a aliquam.','name21','2215.57',NULL,'20'),
('22','Molestiae alias in quo nihil non itaque neque. Commodi maiores possimus labore neque reiciendis doloremque. Dolor dolorem totam quam nostrum quaerat atque laboriosam maxime. Qui harum et et consectetur.','name22','6692',NULL,'4'),
('23','Ex similique laboriosam velit distinctio. Non corporis ducimus unde doloremque ut qui ab.','name23','3967.8',NULL,'11'),
('24','Sit consequuntur ab autem quaerat eum provident eius quidem. Nostrum quis nesciunt ut cum autem. Ipsam et sint earum nemo quaerat.','name24','2405.8',NULL,'19'),
('25','Porro eum architecto molestias. Consequuntur nam consequatur temporibus dolores. Vero maxime ut natus iusto dolore repudiandae.','name25','5244.71',NULL,'19'),
('26','Aspernatur numquam ullam cupiditate maxime aut nesciunt. Quaerat est saepe praesentium quis aut ducimus. Exercitationem doloremque quam perspiciatis est ipsum ut et aliquam. Quasi sint non ut.','name26','7652.88',NULL,'6'),
('27','Repellendus recusandae provident voluptatibus blanditiis qui. Inventore delectus qui dolorem. Nobis aut nihil est odio minima molestiae. Dolor fugiat unde sit debitis ab ipsam.','name27','3144.07',NULL,'3'),
('28','Delectus rerum consequatur dolorum dolorum rerum officia. Laudantium voluptas est eos alias qui asperiores inventore. Necessitatibus corporis officiis temporibus velit sapiente consequuntur maxime. Sint est labore quibusdam qui.','name28','2178.36',NULL,'7'),
('29','Illo assumenda asperiores consequatur hic. Dolor totam voluptas id. Atque error et porro non neque veniam corporis.','name29','6491.65',NULL,'4'),
('30','Alias ullam eum consequuntur labore qui impedit eos. Omnis ut vitae voluptates sed. Sint error voluptatibus molestiae esse aliquam. Ex odit amet et voluptatum possimus reprehenderit qui.','name30','2047.71',NULL,'16'); 


INSERT INTO `quest_pers` VALUES ('1','1',0),
('2','2',0),
('3','3',0),
('4','4',1),
('5','5',0),
('6','6',0),
('7','7',1),
('8','8',0),
('9','9',1),
('10','10',0),
('11','11',0),
('12','12',0),
('13','13',0),
('14','14',1),
('15','15',1),
('16','16',0),
('17','17',0),
('18','18',0),
('19','19',0),
('20','20',0),
('21','21',0),
('22','22',1),
('23','23',1),
('24','24',1),
('25','25',0),
('26','26',0),
('27','27',0),
('28','28',0),
('29','29',0),
('30','30',1); 



 

INSERT INTO `backpack` VALUES ('1','1','101','8','26.38',NULL,NULL),
('2','2','102','4','95.45',NULL,NULL),
('3','3','104','15','22.60',NULL,NULL),
('4','4','105','7','72.50',NULL,NULL),
('5','5','106','7','85.58',NULL,NULL),
('6','6','108','3','6.83',NULL,NULL),
('7','7','109','2','81.23',NULL,NULL),
('8','8','111','8','99.96',NULL,NULL),
('9','9','112','5','11.02',NULL,NULL),
('10','10','113','14','33.00',NULL,NULL),
('11','11','115','1','82.30',NULL,NULL),
('12','12','119','4','22.52',NULL,NULL),
('13','13','121','6','92.25',NULL,NULL),
('14','14','123','7','8.99',NULL,NULL),
('15','15','124','4','63.98',NULL,NULL),
('16','16','125','8','27.15',NULL,NULL),
('17','17','126','6','55.28',NULL,NULL),
('18','18','127','13','90.82',NULL,NULL),
('19','19','128','8','96.75',NULL,NULL),
('20','20','130','11','58.14',NULL,NULL),
('21','21','131','3','92.76',NULL,NULL),
('22','22','132','8','6.51',NULL,NULL),
('23','23','133','7','90.17',NULL,NULL),
('24','24','134','13','60.94',NULL,NULL),
('25','25','135','10','16.71',NULL,NULL),
('26','26','140','2','59.43',NULL,NULL),
('27','27','143','3','53.60',NULL,NULL),
('28','28','145','1','94.55',NULL,NULL),
('29','29','146','13','30.06',NULL,NULL),
('30','30','148','3','77.55',NULL,NULL),
('31','1','149','9','90.14',NULL,NULL),
('32','2','150','1','24.38',NULL,NULL),
('33','3','151','14','19.80',NULL,NULL),
('34','4','152','13','25.46',NULL,NULL),
('35','5','155','4','59.00',NULL,NULL),
('36','6','157','11','72.45',NULL,NULL),
('37','7','160','5','54.45',NULL,NULL),
('38','8','161','5','94.75',NULL,NULL),
('39','9','162','8','80.60',NULL,NULL),
('40','10','163','10','17.20',NULL,NULL),
('41','11','166','13','94.82',NULL,NULL),
('42','12','167','4','95.93',NULL,NULL),
('43','13','171','13','7.26',NULL,NULL),
('44','14','174','15','61.16',NULL,NULL),
('45','15','177','14','8.30',NULL,NULL),
('46','16','179','6','46.00',NULL,NULL),
('47','17','185','5','53.00',NULL,NULL),
('48','18','186','15','71.08',NULL,NULL),
('49','19','187','2','23.99',NULL,NULL),
('50','20','188','4','82.00',NULL,NULL),
('51','21','189','10','28.80',NULL,NULL),
('52','22','192','2','77.89',NULL,NULL),
('53','23','194','1','81.47',NULL,NULL),
('54','24','195','12','69.00',NULL,NULL),
('55','25','196','14','59.21',NULL,NULL),
('56','26','198','3','49.10',NULL,NULL),
('57','27','200','11','59.69',NULL,NULL),
('58','28','101','6','71.18',NULL,NULL),
('59','29','102','8','25.03',NULL,NULL),
('60','30','104','1','81.21',NULL,NULL),
('61','1','105','8','93.40',NULL,NULL),
('62','2','106','6','95.78',NULL,NULL),
('63','3','108','12','15.47',NULL,NULL),
('64','4','109','8','40.46',NULL,NULL),
('65','5','111','15','22.86',NULL,NULL),
('66','6','112','2','40.42',NULL,NULL),
('67','7','113','7','74.89',NULL,NULL),
('68','8','115','15','20.65',NULL,NULL),
('69','9','119','10','84.55',NULL,NULL),
('70','10','121','5','35.48',NULL,NULL),
('71','11','123','3','96.70',NULL,NULL),
('72','12','124','12','48.89',NULL,NULL),
('73','13','125','15','6.00',NULL,NULL),
('74','14','126','9','61.23',NULL,NULL),
('75','15','127','6','68.26',NULL,NULL),
('76','16','128','8','42.00',NULL,NULL),
('77','17','130','1','22.56',NULL,NULL),
('78','18','131','6','61.72',NULL,NULL),
('79','19','132','2','85.98',NULL,NULL),
('80','20','133','8','14.40',NULL,NULL),
('81','21','134','8','17.01',NULL,NULL),
('82','22','135','5','46.59',NULL,NULL),
('83','23','140','5','34.55',NULL,NULL),
('84','24','143','1','34.33',NULL,NULL),
('85','25','145','8','40.42',NULL,NULL),
('86','26','146','11','97.90',NULL,NULL),
('87','27','148','13','42.13',NULL,NULL),
('88','28','149','10','92.04',NULL,NULL),
('89','29','150','6','47.42',NULL,NULL),
('90','30','151','3','60.64',NULL,NULL),
('91','1','152','13','12.00',NULL,NULL),
('92','2','155','8','54.61',NULL,NULL),
('93','3','157','14','51.61',NULL,NULL),
('94','4','160','14','53.40',NULL,NULL),
('95','5','161','8','67.93',NULL,NULL),
('96','6','162','2','32.23',NULL,NULL),
('97','7','163','5','40.62',NULL,NULL),
('98','8','166','1','5.28',NULL,NULL),
('99','9','167','15','86.48',NULL,NULL),
('100','10','171','14','97.00',NULL,NULL); 



