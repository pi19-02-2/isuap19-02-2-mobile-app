
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Остаток=ПолучитьОстаток(НаименованиеТовара);
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьОстаток(СсылкаНаТовар)
	Возврат СсылкаНаТовар.Остатки;	
КонецФункции

&НаКлиенте
Процедура ПриПовторномОткрытии()
	Остаток=ПолучитьОстаток(НаименованиеТовара);
КонецПроцедуры  

&НаКлиенте
Процедура Готово(Команда)
	ДобавитьВКорзину(НаименованиеТовара, Количество);
	ЭтаФорма.Закрыть();
КонецПроцедуры

&НаСервере
Процедура ДобавитьВКорзину(Товар, Кол)
	Если ПустаяСтрока(Константы.Корзина.Получить()) ИЛИ Константы.Корзина.Получить().Проведен=Истина Тогда
		Заказ=Документы.Заказы.СоздатьДокумент();
		Заказ.Дата=ТекущаяДата();
		Заказ.Записать();
		Константы.Корзина.Установить(Заказ.Ссылка);
	КонецЕсли;
	Заказ=Константы.Корзина.Получить().ПолучитьОбъект();
	Если НЕ ЗначениеЗаполнено(Заказ.Товары.Найти(Товар, "Товар")) Тогда
		НоваяСтрока=Заказ.Товары.Добавить();
		НоваяСтрока.Товар=Товар;	
		НоваяСтрока.Количество=Кол;
	Иначе
		КоличествоБыло=Число(Заказ.Товары.Найти(Товар, "Товар").Количество);
		Заказ.Товары.Найти(Товар, "Товар").Количество=КоличествоБыло+Кол;
	КонецЕсли;	
	Заказ.Записать();
КонецПроцедуры	