﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	СохраненныеОстатки = СохраненныеОстатки(ПараметрКоманды);
	СохраненныеОстатки.ТабличныйДокумент.Показать(
		СтрШаблон("Сохраненные остатки %1 на %2", 
		СохраненныеОстатки.ИмяРегистра, Формат(СохраненныеОстатки.ДатаОстатков, "ДФ=dd.MM.yyyy")));
		
КонецПроцедуры

&НаСервере
Функция СохраненныеОстатки(ДокументСсылка)
	
	Возврат Справочники.мт_Тестирование_ЭталонныеОстаткиРегистров.СохраненныеОстатки(ДокументСсылка);
	
КонецФункции