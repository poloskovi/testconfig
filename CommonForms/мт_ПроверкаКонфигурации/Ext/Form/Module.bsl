﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ВосстановитьНастройки();
	
	Элементы.ОписаниеПрочихТестов.Заголовок = 
		"1. Проверка метаданных критериев отбора
		|2. Проверка прочих метаданных
		|3. Синтаксический контроль схем компоновки данных отчетов";
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОтобразитьТекстПредупрежденияОТестированииВРабочейБазе();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;

	СохранитьНастройки();
	
КонецПроцедуры

&НаСервере
Процедура ВосстановитьНастройки()
	
	СтруктураНастроек = ХранилищеОбщихНастроек.Загрузить(ЭтаФорма.ИмяФормы); 
	
	Если ТипЗнч(СтруктураНастроек) = Тип("Структура") Тогда
		СтруктураНастроек.Свойство("СтрокаСоединенияСБазойТестирования", СтрокаСоединенияСБазойТестирования);
		СтруктураНастроек.Свойство("ТестированиеВРабочейБазе", ТестированиеВРабочейБазе);
		СтруктураНастроек.Свойство("ПапкаСценариев", ПапкаСценариев);
	КонецЕсли;
	
	Если ПустаяСтрока(СтрокаСоединенияСБазойТестирования) Тогда
		СтрокаСоединенияСБазойТестирования = "Srvr=""SQL-MET"";Ref=""ERP_TEST3"";";
		ТестированиеВРабочейБазе = ЭтоСтрокаСоединенияСРабочейБазой();
	КонецЕсли;
	
	Если ПустаяСтрока(ПапкаСценариев) Тогда
		ПапкаСценариев = "C:\Users\bexpert\Documents\__Тестирование конфигурации\__Сценарии тестирования";
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СохранитьНастройки()
	
	Настройки = Новый Структура();
	Настройки.Вставить("СтрокаСоединенияСБазойТестирования",СтрокаСоединенияСБазойТестирования);
	Настройки.Вставить("ТестированиеВРабочейБазе", ТестированиеВРабочейБазе);
	Настройки.Вставить("ПапкаСценариев", ПапкаСценариев);
	
	ХранилищеОбщихНастроек.Сохранить(ЭтаФорма.ИмяФормы, , Настройки);
	
КонецПроцедуры

#Область Сценарии_VanessaAutomation

&НаСервере
Функция ЭтоСтрокаСоединенияСРабочейБазой()
	
	Возврат мт_ПрочиеФункцииСервер.ЭтоСтрокаСоединенияСРабочейБазой(СтрокаСоединенияСБазойТестирования);
	
КонецФункции

&НаКлиенте
Функция СтрокаСоединенияСБазойТестированияПоУмолчанию()
	
	Возврат "Srvr=""SQL-MET"";Ref=""ERP_TEST3"";";
	
КонецФункции

&НаСервере
Функция СценарииТестированияВнешнихПечатныхФорм()
	
	возврат мт_ТестированиеКонфигурации_Служебный.СценарииТестированияВнешнихПечатныхФорм(СтрокаСоединенияСБазойТестирования, ТестированиеВРабочейБазе);
	
КонецФункции

&НаСервере
Функция СценарииТестированияОбъектовКонфигурации()
	
	возврат мт_ТестированиеКонфигурации_Служебный.СценарииТестированияОбъектовКонфигурации(СтрокаСоединенияСБазойТестирования, ТестированиеВРабочейБазе);
	
КонецФункции

&НаКлиенте
Процедура ЗаписатьФайлыСценариев(Сценарии, ШаблонИмениФайла)
	
	Для Каждого Сценарий Из Сценарии Цикл
		
		РольПользователя = Сценарий.Ключ;
		Если Не ЗначениеЗаполнено(РольПользователя) Тогда
			РольПользователя = "ПолныеПрава";
		КонецЕсли;
		
		ИмяФайла = СтрШаблон(ШаблонИмениФайла, РольПользователя);
		ТекстСценария = Сценарий.Значение;
		ТекстСценария.Записать(ИмяФайла, КодировкаТекста.UTF8);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаСоздатьСценарииТестирования(Команда)
	
	УдалитьФайлы(ПапкаСценариев, "Тестирование внешних печатных форм*.feature");
	УдалитьФайлы(ПапкаСценариев, "Тестирование объектов конфигурации*.feature");
	
	Сценарии = СценарииТестированияВнешнихПечатныхФорм();
	ШаблонИмениФайла = ПапкаСценариев+"\Тестирование внешних печатных форм %1.feature";
	ЗаписатьФайлыСценариев(Сценарии, ШаблонИмениФайла);
	
	Сценарии = СценарииТестированияОбъектовКонфигурации();
	ШаблонИмениФайла = ПапкаСценариев+"\Тестирование объектов конфигурации %1.feature";
	ЗаписатьФайлыСценариев(Сценарии, ШаблонИмениФайла);
	
	мт_ПрочиеФункцииКлиент.ПоказатьСообщение_ОК("Созданы сценарии тестирования.
		|Запустите базу - менеджер тестирования, откройте обработку Vanessa Automation и выполните тесты.");
	
КонецПроцедуры

&НаКлиенте
Процедура ПапкаСценариевНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ДиалогВыбораКаталога = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ОписаниеОповещения = Новый ОписаниеОповещения("ПапкаСценариевНачалоВыбора_Продолжение", ЭтотОбъект);
	ДиалогВыбораКаталога.Показать(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПапкаСценариевНачалоВыбора_Продолжение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы = Неопределено Тогда
		возврат;
	КонецЕсли;
	
	ПапкаСценариев = ВыбранныеФайлы[0];
	
КонецПроцедуры

&НаКлиенте
Процедура ПутьКБазеДанныхПриИзменении(Элемент)
	
	ТестированиеВРабочейБазе = ЭтоСтрокаСоединенияСРабочейБазой();
	ОтобразитьТекстПредупрежденияОТестированииВРабочейБазе();
	
КонецПроцедуры

&НаКлиенте
Процедура ТестированиеВРабочейБазеПриИзменении(Элемент)

	ОтобразитьТекстПредупрежденияОТестированииВРабочейБазе();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтобразитьТекстПредупрежденияОТестированииВРабочейБазе()
	
	Если ТестированиеВРабочейБазе Тогда
		ТекстПредупреждения = "При тестированиии в рабочей базе будут отключены некоторые тесты, которые изменяют сохраняемые данные";
	Иначе
		ТекстПредупреждения = "";
	КонецЕсли;
	
	Элементы.ТекстПредупрежденияОТестированииВРабочейБазе.Заголовок = ТекстПредупреждения;
	
КонецПроцедуры

#КонецОбласти

#Область РассылкиНаЭлектроннуюПочту

&НаСервере
Функция КомандаТестированиеРассылокНаСервере()
	
	МенеджерыДокументов = Новый Массив;
	МенеджерыДокументов.Добавить(Документы.мт_АктОБраке);
	МенеджерыДокументов.Добавить(Документы.мт_ВходнойКонтроль);
	МенеджерыДокументов.Добавить(Документы.мт_ЗаявкаНаКонтрольОТК);
	МенеджерыДокументов.Добавить(Документы.мт_ПроверкаОТК);
	МенеджерыДокументов.Добавить(Документы.мт_СогласованиеОтклонений);
	
	РежимТестирования = Истина;
	Для Каждого Менеджер Из МенеджерыДокументов Цикл
		
		НавигационнаяСсылка = Менеджер.НавигационнаяСсылкаТестированияРассылки();
		Если Не ЗначениеЗаполнено(НавигационнаяСсылка) Тогда
			ВызватьИсключение "Не указана ссылка для тестирования в документе "+Строка(Менеджер);
		КонецЕсли;
		
		Попытка
			СсылкаДокумента = мт_ПрочиеФункцииСервер.СсылкаИзНавигационнойСсылки(НавигационнаяСсылка);
		Исключение
			ВызватьИсключение "Не смог разобрать навигационную ссылку в документе "+Строка(Менеджер);
		КонецПопытки;
		
		Если Не ЗначениеЗаполнено(СсылкаДокумента) Тогда
			ВызватьИсключение "Не указана ссылка для тестирования в документе "+Строка(Менеджер);
		КонецЕсли;
		
		Менеджер.РазослатьПисьмаПоЭлектроннойПочте(СсылкаДокумента, РежимТестирования);
		
	КонецЦикла;
	
	Возврат МенеджерыДокументов.Количество();
	
КонецФункции

&НаКлиенте
Процедура КомандаТестированиеРассылок(Команда)
	
	КоличествоПисем = КомандаТестированиеРассылокНаСервере();
	
	мт_ПрочиеФункцииКлиент.ПоказатьСообщение_ОК(СтрШаблон("Письма высланы. Проверьте свою электронную почту, указанную в настроках пользователя
		|Должно прийти %1 писем", КоличествоПисем));
	
КонецПроцедуры

#КонецОбласти

#Область РольАудитора

&НаСервере
Процедура КомандаПроверитьРольАудитораНаСервере(Отказ)
	
	мт_ТестированиеКонфигурации_Сервер.ПроверитьРольАудитора(Отказ);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаПроверитьРольАудитора(Команда)
	
	Отказ = Ложь;
	КомандаПроверитьРольАудитораНаСервере(Отказ);
	
	Если Отказ Тогда
		ПоказатьПредупреждение(, "Тест не пройден");
	Иначе
		мт_ПрочиеФункцииКлиент.ПоказатьСообщение_ОК("Успешно.
			|Дополнительно нужно зайти в 1С под пользователелем Аудитор и визуально проверить видимость всех необходимых пунктов меню
			|(сравнивайте с видимостью их под полными правами)");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ПрочиеТесты

&НаСервере
Процедура КомандаПрочиеТестыНаСервере(Отказ)
	
	мт_ТестированиеКонфигурации_Сервер.ПроверитьКритерииОтбора(Отказ);
	мт_ТестированиеКонфигурации_Сервер.ПроверитьПрочиеМетаданные(Отказ);
	мт_ТестированиеКонфигурации_Сервер.СинтаксическаяПроверкаСхемКомпоновкиДанныхОтчетов(Отказ);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаПрочиеТесты(Команда)
	
	Отказ = Ложь;
	КомандаПрочиеТестыНаСервере(Отказ);
	
	Если Отказ Тогда
		ПоказатьПредупреждение(, "Тест не пройден");
	Иначе
		мт_ПрочиеФункцииКлиент.ПоказатьСообщение_ОК("Успешно");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

