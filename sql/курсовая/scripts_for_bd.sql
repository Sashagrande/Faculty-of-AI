-- Представления

-- Выведем игроков и их уровни, у которых в рюкзаке лежит дробовик
drop view if exists shotgun_man;
create view shotgun_man (pers_id, lvl) as
select pers_id, lvl
from pers p2 
where pers_id in
(select pers_id from backpack b2 where loot_id in (select gun_id from guns g2 where class = 'shotgun'));


-- Выведем игроков и их уровни, у которых в рюкзаке лежит пулемет

create or replace view mg_man (pers_id, lvl) as
select pers_id, lvl
from pers p2 
where pers_id in
(select pers_id from backpack b2 where loot_id in (select gun_id from guns g2 where class = 'machine gun'));

select * from mg_man;


-- -------------------------------------------------------------------------------------
-- select запросы
-- выведем сколько персонажей каждого уровня в игре
select lvl, count(*)
from pers p 
group by lvl;

-- откроем рюкзак персонажа с pers_id
set @pers_bp = 5;
select loot_id from backpack b 
where pers_id = @pers_bp;

-- выведем предметы нужной нам категории
set @cat = 'guns';
select loot_id, cat_id, lc.name
from loot l2 
join loot_categories lc on cat_id = category
having lc.name = @cat
;

-- вывести loot_id и цену на патроны калибра @cal
set @cal = '12';
select loot_id, price, caliber
from loot l 
join ammunition a on loot_id = ammo_id
having caliber = @cal;


-- -------------------------------------------------------------------------------


-- Процедура объединения лута, если допустим в рюкзаке у одного персонажа, есть две позиции одинаковых предметов
-- например у персонажа с pers_id = 5 в рюкзаке две позиции loot_id, loot_id = 15 в количестве 5 штук, и loot_id = 15 в количестве 3 штуки
-- функция объединит этот лут в одну ячейку, и loot_id = 15 станет 8 штук
DROP PROCEDURE IF EXISTS bd_rpg_game.sp_union_loot;

DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `bd_rpg_game`.`sp_union_loot`(in prs_id bigint unsigned)
BEGIN
	declare bcp_id bigint unsigned;
	declare lt_id int unsigned;
	declare `_rollback` bit default 0;
		declare continue HANDLER for sqlexception
	begin
		set `_rollback` = 1;		
	end;
	start transaction;
set bcp_id = (select backp_id from backpack b where pers_id = prs_id group by loot_id HAVING count(*) > 1);
set lt_id = (select loot_id from backpack b where pers_id = prs_id group by loot_id HAVING count(*) > 1);


update backpack 
set quantity = (select sum(quantity) -- сложим количество одинакового loot_id и поместим в первую строку
from (select quantity from backpack b 
	where pers_id in (select pers_id from backpack b where pers_id = prs_id group by loot_id HAVING count(*) > 1) and 
	loot_id in (select loot_id from backpack b where pers_id = prs_id group by loot_id HAVING count(*) > 1))a)
	where pers_id = prs_id and backp_id = bcp_id;

delete from backpack where backp_id != bcp_id and loot_id = lt_id and pers_id = prs_id; -- удалим все строки кроме первой


	if `_rollback` = 1 then rollback;
		else commit;
	end if;
	
END$$
DELIMITER ;





-- Процедура передачи лута от одного персонажа к другому
DROP PROCEDURE IF EXISTS bd_rpg_game.`sp_transfer_of_loot`;

DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `bd_rpg_game`.`sp_transfer_of_loot`(in from_user bigint, in to_user bigint, in b_id bigint, in q int)
BEGIN
	declare `_rollback` bit default 0;
	declare continue HANDLER for sqlexception
	begin
		set `_rollback` = 1;
		
	end;
	start transaction;


	INSERT INTO backpack
	select null, to_user, loot_id, q, state, mod1, mod2 from backpack where backp_id = b_id;

	update backpack 
	set quantity = quantity - q -- вычтем из рюкзака отдающего игрока лут, который он передает принимающему
	where pers_id = from_user and backp_id = b_id;

	delete from backpack where quantity = 0; -- удалим позицию из рюкзака отдающего, если он передал весь loot_id
	call union_loot(to_user); -- тут же вызываем процедуру объединения лута, чтобы оптимизировать рюкзак принимающего
	
	if `_rollback` = 1 then rollback;
		else commit;
	end if;

END$$
DELIMITER ;



set @from_user = 8, @to_user = 3, @b_id = 68, @q = 3; -- передадим от персонажа 8 к персонажу 3 лут из рюкзака с backp_id = 68 в количестве 3шт

call sp_transfer_of_loot(@from_user, @to_user, @b_id, @q);

call sp_union_loot(5); -- предположим что игрок с pers_id = 5 решил оптимизировать место в своем рюкзаке



-- -----------------------------------------------------------------------------------
DROP TRIGGER IF EXISTS bd_rpg_game.not_young; -- не даем зарегистрироваться пользователям младше 18 лет
USE bd_rpg_game;

DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` TRIGGER `not_young` AFTER INSERT ON `users` FOR EACH ROW if (new.birthday + interval 18 year) > now() then 
 		signal sqlstate '45000'
 			set MESSAGE_TEXT = 'Игра для людей старше 18 лет';
 			end if$$
DELIMITER ;

INSERT INTO `users` VALUES  -- испытаем тригер
(225,'ddwfttbtch','Bly','Wims','yasfrfer@example.com','ce7какa92e7ac910fdbb4','2010-02-01',now(),NULL,0);