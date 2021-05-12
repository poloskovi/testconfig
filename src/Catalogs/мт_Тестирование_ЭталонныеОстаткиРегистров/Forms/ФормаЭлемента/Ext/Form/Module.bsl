﻿
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ЗаблокироватьДанныеОтИзменений(Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РазрешитьРедактирование(Команда)
	ЗаблокироватьДанныеОтИзменений(Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ЗаблокироватьДанныеОтИзменений(Заблокировать)
	
	ЭтаФорма.ТолькоПросмотр = Заблокировать;
	
КонецПроцедуры

&НаСервере
Процедура ПолучитьОстаткиНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Период", Объект.ДатаОстатков);
	Запрос.Текст = "ВЫБРАТЬ
	               |	Т.*
	               |ИЗ
	               |	РегистрНакопления." + Объект.Наименование + ".Остатки(&Период, ) КАК Т";
	
	ТаблицаОстатков = Запрос.Выполнить().Выгрузить();
	ДействияСТаблицейОстатков(ТаблицаОстатков);
	
КонецПроцедуры

&НаСервере
Процедура ДействияСТаблицейОстатков(ТаблицаОстатков)
	
	Объект.КоличествоЗаписей = ТаблицаОстатков.Количество();
	АдресХранилищаТаблицыОстатков = ПоместитьВоВременноеХранилище(ТаблицаОстатков, ЭтаФорма.УникальныйИдентификатор);
	НеобходимоСохранитьДанные = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьОстатки(Команда)
	
	Если ЭтаФорма.ПроверитьЗаполнение() Тогда
		ПолучитьОстаткиНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если НеобходимоСохранитьДанные Тогда
		ТаблицаОстатков = ПолучитьИзВременногоХранилища(АдресХранилищаТаблицыОстатков);
		ТекущийОбъект.СохраненныеДанные = Новый ХранилищеЗначения(ТаблицаОстатков, Новый СжатиеДанных(9));
	КонецЕсли;
	
КонецПроцедуры

#Область ВыгрузкаЗагрузка

&НаКлиенте
Процедура ВыгрузитьВФайл(Команда) 
	
	Если ЭтаФорма.Модифицированность Тогда
		ПоказатьПредупреждение(, "Сначала сохраните файл");
	КонецЕсли;
	
	ВыгрузитьОстаткиВФайлАсинх();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьИзФайла(Команда)
	
	ЗагрузитьОстаткиИзФайлаАсинх();
	
КонецПроцедуры

&НаКлиенте
Асинх Процедура ВыгрузитьОстаткиВФайлАсинх()
	
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогВыбораФайла.ПолноеИмяФайла = Объект.Наименование + " от " + Формат(Объект.ДатаОстатков, "ДФ=yyyy-MM-dd");
	ДиалогВыбораФайла.Фильтр = "Файл XML (*.xml)|*.xml";
	ДиалогВыбораФайла.МножественныйВыбор = Ложь;
	Обещание = ДиалогВыбораФайла.ВыбратьАсинх();
	
	Результат = Ждать Обещание;
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИмяФайла = Результат[0];
	
	ДанныеСтрокой = ПолучитьСохраненныеДанныеВВидеXML();
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.ДобавитьСтроку(ДанныеСтрокой);
	ТекстовыйДокумент.Записать(ИмяФайла, "UTF8");
	
КонецПроцедуры

&НаСервере
Функция ПолучитьСохраненныеДанныеВВидеXML()
	
	СпрОбъект = РеквизитФормыВЗначение("Объект");
	ТаблицаОстатков = СпрОбъект.СохраненныеДанные.Получить();
	
	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.УстановитьСтроку("UTF-8");
	
	СохраняемыеДанные = Новый Структура();
	СохраняемыеДанные.Вставить("Наименование", Объект.Наименование);
	СохраняемыеДанные.Вставить("ДатаОстатков", Объект.ДатаОстатков);
	СохраняемыеДанные.Вставить("ТаблицаОстатков", ТаблицаОстатков);
	
	СериализаторXDTO.ЗаписатьXML(ЗаписьXML, СохраняемыеДанные, НазначениеТипаXML.Явное);
	ДанныеКакСтрока = ЗаписьXML.Закрыть();
	
	Возврат ДанныеКакСтрока;
	
КонецФункции

&НаКлиенте
Асинх Процедура ЗагрузитьОстаткиИзФайлаАсинх()
	
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогВыбораФайла.Фильтр = "Файл XML (*.xml)|*.xml";
	ДиалогВыбораФайла.МножественныйВыбор = Ложь;
	Обещание = ДиалогВыбораФайла.ВыбратьАсинх();
	
	Результат = Ждать Обещание;
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИмяФайла = Результат[0];
	
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.Прочитать(ИмяФайла, "UTF8");
	ПрочитатьДанныеИзФайла(ТекстовыйДокумент.ПолучитьТекст());
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьДанныеИзФайла(ДанныеСтрокой)
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.Прочитать();
	ЧтениеXML.УстановитьСтроку(ДанныеСтрокой);
	
	СохраненныеДанные = СериализаторXDTO.ПрочитатьXML(ЧтениеXML);
	
	ТаблицаОстатков = СохраненныеДанные.ТаблицаОстатков;
	Объект.Наименование = СохраненныеДанные.Наименование;
	Объект.ДатаОстатков = СохраненныеДанные.ДатаОстатков;
	
	ДействияСТаблицейОстатков(ТаблицаОстатков);
	
КонецПроцедуры

#КонецОбласти
