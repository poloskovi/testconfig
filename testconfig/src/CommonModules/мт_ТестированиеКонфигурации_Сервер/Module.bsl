
//Эта функция вызывается при каждом запуске системы от имени пользователя с полными правами, 
//и проверяет сохранность метаданных, нарушение которой приводит к потере данных базы

Процедура ПроверкаСохранностиКритическихМетаданных(Отказ) Экспорт
	
	Если Не РольДоступна("ПолныеПрава") Тогда
		возврат;
	КонецЕсли;
	
	ПроверитьДвижения(Отказ);
	ПроверитьОпределяемыеТипы(Отказ);
	
КонецПроцедуры

Процедура ПроверитьДвижения(Отказ)
	
	ПроверенныеДвижения = Новый Соответствие;
	
	ПроверитьДвижения_ВозвратСырьяОтПереработчика(Отказ, ПроверенныеДвижения);
	
	мт_ТестированиеКонфигурации_Служебный.ПолучитьНепроверенныеДвиженияПоДокументам(ПроверенныеДвижения, Отказ);
	
КонецПроцедуры

Процедура ПроверитьОпределяемыеТипы(Отказ)
	
	ПроверенныеТипы = Новый Соответствие;
	
	ПроверитьОпределяемыйТип_ВладелецПрисоединенныхФайлов(Отказ, ПроверенныеТипы);
	ПроверитьОпределяемыйТип_ПрисоединенныйФайл(Отказ, ПроверенныеТипы);
	ПроверитьОпределяемыйТип_ПрисоединенныйФайлОбъект(Отказ, ПроверенныеТипы);
	
	ЗаголовокСообщенияОбОшибке = "Не выполняется проверка определяемых типов:";
	мт_ТестированиеКонфигурации_Служебный.СообщитьОНепроверенныхТипах(ПроверенныеТипы, Отказ, Метаданные.ОпределяемыеТипы, ЗаголовокСообщенияОбОшибке);
	
КонецПроцедуры

#Область ПроверкаДвижений

Процедура ПроверитьДвижения_ВозвратСырьяОтПереработчика(Отказ, ПроверенныеДвижения)
	
	МетаданныеДокумента = Метаданные.Документы.ВозвратСырьяОтПереработчика;
	
	ТребуемыеДвижения = Новый Массив;
	
	//пример:
	//ТребуемыеДвижения.Добавить(Метаданные.РегистрыНакопления.мт_ДвижениеПроизводственныхПартий);
	//ТребуемыеДвижения.Добавить(Метаданные.РегистрыНакопления.мт_МатериалыУПереработчика);
	//ТребуемыеДвижения.Добавить(Метаданные.РегистрыНакопления.мт_МатериалыУПереработчика_БезСерий);
	
	мт_ТестированиеКонфигурации_Служебный.ПроверитьНаличиеДвижений(МетаданныеДокумента, ТребуемыеДвижения, Отказ, ПроверенныеДвижения);
	
КонецПроцедуры

#КонецОбласти

#Область ПроверкаОпределяемыхТипов

Процедура ПроверитьОпределяемыйТип_ВладелецПрисоединенныхФайлов(Отказ, ПроверенныеТипы)
	
	МетаданныеОпределяемогоТипа = Метаданные.ОпределяемыеТипы.ВладелецПрисоединенныхФайлов;
	
	ТребуемыеТипы = Новый Массив;
	
	//пример:
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_АктОБраке"));
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_АктОБраке_Списание"));
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_СогласованиеОтклонений"));
	
	мт_ТестированиеКонфигурации_Служебный.ПроверитьВхождениеТипов_в_ТипМетаданного(МетаданныеОпределяемогоТипа, ТребуемыеТипы, Отказ, ПроверенныеТипы)
	
КонецПроцедуры

Процедура ПроверитьОпределяемыйТип_ПрисоединенныйФайл(Отказ, ПроверенныеТипы)
	
	МетаданныеОпределяемогоТипа = Метаданные.ОпределяемыеТипы.ПрисоединенныйФайл;
	
	ТребуемыеТипы = Новый Массив;
	
	//пример:
	//ТребуемыеТипы.Добавить(Тип("СправочникСсылка.мт_АктОБракеПрисоединенныеФайлы"));
	//ТребуемыеТипы.Добавить(Тип("СправочникСсылка.мт_АктОБраке_СписаниеПрисоединенныеФайлы"));
	//ТребуемыеТипы.Добавить(Тип("СправочникСсылка.мт_СогласованиеОтклоненийПрисоединенныеФайлы"));
	
	мт_ТестированиеКонфигурации_Служебный.ПроверитьВхождениеТипов_в_ТипМетаданного(МетаданныеОпределяемогоТипа, ТребуемыеТипы, Отказ, ПроверенныеТипы)
	
КонецПроцедуры

Процедура ПроверитьОпределяемыйТип_ПрисоединенныйФайлОбъект(Отказ, ПроверенныеТипы)
	
	МетаданныеОпределяемогоТипа = Метаданные.ОпределяемыеТипы.ПрисоединенныйФайлОбъект;
	
	ТребуемыеТипы = Новый Массив;
	
	//пример:
	//ТребуемыеТипы.Добавить(Тип("СправочникОбъект.мт_АктОБракеПрисоединенныеФайлы"));
	//ТребуемыеТипы.Добавить(Тип("СправочникОбъект.мт_АктОБраке_СписаниеПрисоединенныеФайлы"));
	//ТребуемыеТипы.Добавить(Тип("СправочникОбъект.мт_СогласованиеОтклоненийПрисоединенныеФайлы"));
	
	мт_ТестированиеКонфигурации_Служебный.ПроверитьВхождениеТипов_в_ТипМетаданного(МетаданныеОпределяемогоТипа, ТребуемыеТипы, Отказ, ПроверенныеТипы)
	
КонецПроцедуры

#КонецОбласти

#Область ПроверкаКритериевОтбора

Процедура ПроверитьКритерииОтбора(Отказ) Экспорт
	
	ПроверенныеТипы = Новый Соответствие;
	ПроверенныйСостав = Новый Соответствие;
	
	ПроверитьКритерийОтбора_СвязанныеДокументы(Отказ, ПроверенныеТипы, ПроверенныйСостав);
	
	ЗаголовокСообщенияОбОшибке = "Не выполняется проверка типов критериев отбора:";
	мт_ТестированиеКонфигурации_Служебный.СообщитьОНепроверенныхТипах(ПроверенныеТипы, Отказ, Метаданные.КритерииОтбора, ЗаголовокСообщенияОбОшибке);
	
	ЗаголовокСообщенияОбОшибке = "Не выполняется проверка состава критериев отбора:";
	мт_ТестированиеКонфигурации_Служебный.СообщитьОНепроверенномСоставе(ПроверенныйСостав, Отказ, Метаданные.КритерииОтбора, ЗаголовокСообщенияОбОшибке);
	
КонецПроцедуры

Процедура ПроверитьКритерийОтбора_СвязанныеДокументы(Отказ, ПроверенныеТипы, ПроверенныйСостав)
	
	ОбъектМетаданных = Метаданные.КритерииОтбора.СвязанныеДокументы;
	
	ОписаниеТипов = ОбъектМетаданных.Тип;
	
	ТребуемыеТипы = Новый Массив;
	
	//пример:
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_АктОБраке"));
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_АктОБраке_Списание"));
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_АктОБраке_ТехнологическийАкт"));
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_ВходнойКонтроль"));
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_ЗаявкаНаКонтрольОТК"));
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_ИсправлениеБрака"));
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_ПроизводственныеПартии"));
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_Сборки"));
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_СборочнаяВедомость"));
	
	мт_ТестированиеКонфигурации_Служебный.ПроверитьВхождениеТипов_в_ТипМетаданного(ОбъектМетаданных, ТребуемыеТипы, Отказ, ПроверенныеТипы);
	
	ТребуемыйСостав = Новый Массив;
	
	//пример:
	//ТребуемыйСостав.Добавить(Метаданные.Документы.МаршрутныйЛистПроизводства.ТабличныеЧасти.мт_Сборки.Реквизиты.ДокументСборки);
	//ТребуемыйСостав.Добавить(Метаданные.Документы.ЗаказНаПроизводство2_2.ТабличныеЧасти.Продукция.Реквизиты.мт_ПроизводственнаяПартия);
	//ТребуемыйСостав.Добавить(Метаданные.Документы.СборкаТоваров.Реквизиты.мт_ДокументОснование);
	//ТребуемыйСостав.Добавить(Метаданные.Документы.ЭтапПроизводства2_2.ТабличныеЧасти.мт_Сборки.Реквизиты.ДокументСборки);
	
	мт_ТестированиеКонфигурации_Служебный.ПроверитьВхождениеВСостав(ОбъектМетаданных, ТребуемыйСостав, Отказ, ПроверенныйСостав);
	
КонецПроцедуры

#КонецОбласти

#Область ПроверкаПрочихМетаданных

Процедура ПроверитьПрочиеМетаданные(Отказ) Экспорт
	
	ПроверитьИзмененныеТипыРеквизитовОбъектов(Отказ);
	
КонецПроцедуры

Процедура ПроверитьИзмененныеТипыРеквизитовОбъектов(Отказ)
	
	//пример:
	//ПроверенныеТипы = Новый Соответствие;
	//
	//ОбъектМетаданных = Метаданные.Документы.ПеремещениеТоваров.Реквизиты.ДокументОснование;
	//
	//ТребуемыеТипы = Новый Массив;
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_АктОБраке"));
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_АктОБраке_Списание"));
	//ТребуемыеТипы.Добавить(Тип("ДокументСсылка.мт_АктОБраке_ТехнологическийАкт"));
	//
	//мт_ТестированиеКонфигурации_Служебный.ПроверитьВхождениеТипов_в_ТипМетаданного(ОбъектМетаданных, ТребуемыеТипы, Отказ, ПроверенныеТипы)
	
КонецПроцедуры

#КонецОбласти

#Область СинтаксическаяПроверкаСхемКомпоновкиДанныхОтчетов

Процедура СинтаксическаяПроверкаСхемКомпоновкиДанныхОтчетов(Отказ) Экспорт
	
	//Идеи взяты отсюда: https://github.com/vanessa-opensource/add/tree/master/tests/smoke/тесты_ПроверкаМакетовСКД
	//Сделал проверку только отчетов. Не сделал проверку вложенных схем
	//При случае доделать

	Для Каждого ОбъектМетаданных Из Метаданные.Отчеты Цикл
		
		Менеджер = Отчеты;
		
		Если Не мт_ТестированиеКонфигурации_Служебный.ОбъектНаПоддержке(ОбъектМетаданных) Тогда
			Для Каждого МетаданныеМакета Из ОбъектМетаданных.Макеты Цикл
				
				Если МетаданныеМакета.ТипМакета = Метаданные.СвойстваОбъектов.ТипМакета.СхемаКомпоновкиДанных Тогда
					
					СхемаКомпоновкиДанных = Менеджер[ОбъектМетаданных.Имя].ПолучитьМакет(МетаданныеМакета.Имя);
					ПроверитьСхемуСКД(СхемаКомпоновкиДанных, Отказ, ОбъектМетаданных.ПолноеИмя());
					
				КонецЕсли;
				
			КонецЦикла;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ПроверитьСхемуСКД(СхемаКомпоновкиДанных, Отказ, ПолноеИмяОбъектаМетаданных)

	ДанныеРасшифровки = Новый ДанныеРасшифровкиКомпоновкиДанных;
	
	КомпоновщикНастроекКомпоновкиДанных = Новый КомпоновщикНастроекКомпоновкиДанных;
	
	Попытка
		ИсточникДоступныхНастроекКомпоновкиДанных = Новый ИсточникДоступныхНастроекКомпоновкиДанных(СхемаКомпоновкиДанных);
		// Тут проходит синтаксический анализ запроса.
    	КомпоновщикНастроекКомпоновкиДанных.Инициализировать(ИсточникДоступныхНастроекКомпоновкиДанных);
	Исключение
		ТекстСообщения = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		ТекстСообщения = "Ошибка при проверке схемы компоновки данных " + ПолноеИмяОбъектаМетаданных 
			+ Символы.ВК
			+ ТекстСообщения;
		СообщитьОбОшибке(ТекстСообщения, Отказ);
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#Область РольАудитора

Процедура ПроверитьРольАудитора(Отказ) Экспорт
	
	//по состоянию на 12.08.2020 (2.4.12.83) видно не все, но для аудитора, как мне кажется, достаточно.
	
	ПроверяемаяРоль = Метаданные.Роли.мт_ВсеДляПросмотра;
	
	ИсключаемыеМетаданные = РольАудитора_ИсключаемыеМетаданные();
	ДополнительноПроверить = РольАудитора_ДополнительноПроверить();
	
	Проверять = Новый Соответствие;
	Проверять.Вставить(Метаданные.Подсистемы, "Просмотр");
	Проверять.Вставить(Метаданные.ПараметрыСеанса, "Получение, Установка");
	Проверять.Вставить(Метаданные.ОбщиеРеквизиты, "Просмотр");
	Проверять.Вставить(Метаданные.ПланыОбмена, "Просмотр");
	Проверять.Вставить(Метаданные.КритерииОтбора, "Просмотр");
	Проверять.Вставить(Метаданные.ОбщиеФормы, "Просмотр");
	Проверять.Вставить(Метаданные.ОбщиеКоманды, "Просмотр");
	Проверять.Вставить(Метаданные.Константы, "Просмотр");
	Проверять.Вставить(Метаданные.Справочники, "Просмотр");
	Проверять.Вставить(Метаданные.Документы, "Просмотр");
	Проверять.Вставить(Метаданные.ЖурналыДокументов, "Просмотр");
	Проверять.Вставить(Метаданные.Отчеты, "Использование, Просмотр");
	Проверять.Вставить(Метаданные.Обработки, "Использование, Просмотр");
	Проверять.Вставить(Метаданные.ПланыВидовРасчета, "Просмотр");
	Проверять.Вставить(Метаданные.ПланыВидовХарактеристик, "Просмотр");
	Проверять.Вставить(Метаданные.ПланыСчетов, "Просмотр");
	Проверять.Вставить(Метаданные.РегистрыБухгалтерии, "Просмотр");
	Проверять.Вставить(Метаданные.РегистрыНакопления, "Просмотр");
	Проверять.Вставить(Метаданные.РегистрыРасчета, "Просмотр");
	Проверять.Вставить(Метаданные.РегистрыСведений, "Просмотр");
	
	Для Каждого Раздел Из Проверять Цикл
	
		Если Не ЗначениеЗаполнено(Раздел.Значение) Тогда
			СообщитьОбОшибке("Не указано, что проверять: "+Строка(Раздел), Отказ);
			продолжить;
		КонецЕсли;
		
		ПраваКПроверке = Новый Структура(Раздел.Значение);
		
		Для Каждого ОбъектМетаданных Из Раздел.Ключ Цикл
			
			ДолжноБытьПравоДоступа = ИсключаемыеМетаданные.Найти(ОбъектМетаданных) = Неопределено;
			
			Для Каждого Право Из ПраваКПроверке Цикл
				
				ЕстьПравоДоступа = ПравоДоступа(Право.Ключ, ОбъектМетаданных, ПроверяемаяРоль);
			
				Если Не ЕстьПравоДоступа = ДолжноБытьПравоДоступа Тогда
					
					Если ДолжноБытьПравоДоступа Тогда
						ТекстОшибки = СтрШаблон("Нет доступа %1 к %2", Право.Ключ, ОбъектМетаданных.ПолноеИмя());
					Иначе
						ТекстОшибки = СтрШаблон("Есть доступ %1 к %2", Право.Ключ, ОбъектМетаданных.ПолноеИмя());
					КонецЕсли;	
					
					СообщитьОбОшибке(ТекстОшибки, Отказ);
					
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЦикла;
		
	КонецЦикла;
	
	//дополнительно
	Для Каждого ЭлементДополнительнойПроверки Из ДополнительноПроверить Цикл
		
		ОбъектМетаданных = ЭлементДополнительнойПроверки.Ключ;
		
		Если Не ЗначениеЗаполнено(ЭлементДополнительнойПроверки.Значение) Тогда
			СообщитьОбОшибке("Не указано, что проверять: "+Строка(ОбъектМетаданных), Отказ);
			продолжить;
		КонецЕсли;
		
		ПраваКПроверке = Новый Структура(ЭлементДополнительнойПроверки.Значение);
		
		ДолжноБытьПравоДоступа = ИсключаемыеМетаданные.Найти(ОбъектМетаданных) = Неопределено;
			
		Для Каждого Право Из ПраваКПроверке Цикл
			
			ЕстьПравоДоступа = ПравоДоступа(Право.Ключ, ОбъектМетаданных, ПроверяемаяРоль);
			
			Если Не ЕстьПравоДоступа = ДолжноБытьПравоДоступа Тогда
				
				Если ДолжноБытьПравоДоступа Тогда
					ТекстОшибки = СтрШаблон("Нет доступа %1 к %2", Право.Ключ, ОбъектМетаданных.ПолноеИмя());
				Иначе
					ТекстОшибки = СтрШаблон("Есть доступ %1 к %2", Право.Ключ, ОбъектМетаданных.ПолноеИмя());
				КонецЕсли;	
				
				СообщитьОбОшибке(ТекстОшибки, Отказ);
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

Функция РольАудитора_ИсключаемыеМетаданные()
	
	//кроме чертежей и обработки СамообслуживаниеПартнеров, все остальное исключать не обязательно
	
	Результат = Новый Массив;
	
	//это исключать обязательно:
	Результат.Добавить(Метаданные.Обработки.СамообслуживаниеПартнеров);	//если есть право на эту обработку, то вылетает ошибка при запуске 1С
																		//у администратора этого права нет.
	
	//а это не обязательно:
	
	//пример
	//Результат.Добавить(Метаданные.Подсистемы.мт_МатериальноТехническоеСнабжение);
	//Результат.Добавить(Метаданные.Подсистемы.мт_Физлица);
	//
	//Результат.Добавить(Метаданные.ОбщиеКоманды.мт_ПроверкаКонфигурации);
	//
	//Результат.Добавить(Метаданные.ОбщиеФормы.мт_ПроверкаКонфигурации);
	//
	//Результат.Добавить(Метаданные.Обработки.мт_ОбменСРабочимМестомСборщика);
	//Результат.Добавить(Метаданные.Обработки.мт_ПерезаполнитьСлужебныеРегистрыОТК);
	//Результат.Добавить(Метаданные.Обработки.мт_ПоменятьВладельцаПрисоединенногоФайлаНоменклатуры);
	
	возврат Результат;
	
КонецФункции

Функция РольАудитора_ДополнительноПроверить()
	
	Результат = Новый Соответствие;
	
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.БанковскиеСчетаКонтрагентов.Команды.БанковскиеСчетаПартнеров);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.БанковскиеСчетаОрганизаций.Команды.БанковскиеСчета);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.БанковскиеСчетаОрганизаций.Команды.БанковскиеСчетаОрганизации);
	
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.ДоговорыКонтрагентов.Команды.ДоговорыСКлиентами);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.ДоговорыКонтрагентов.Команды.ДоговорыСПоставщиками);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.ДоговорыКонтрагентов.Команды.ДоговорыСПартнером);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.ДоговорыКонтрагентов.Команды.ДоговорыСКонтрагентом);
	
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.Кассы.Команды.КассыПредприятия);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.Кассы.Команды.КассыОрганизации);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.Кассы.Команды.КассыКассовойКниги);
	
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.Номенклатура.Команды.Номенклатура);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.Организации.Команды.Организации);
	
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.Партнеры.Команды.Клиенты);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.Партнеры.Команды.Конкуренты);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.Партнеры.Команды.Поставщики);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.Партнеры.Команды.Партнеры);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.Партнеры.Команды.Контрагенты);
	
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.Склады.Команды.Склады);
	
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.СоглашенияСКлиентами.Команды.ОткрытиеСпискаТиповыхСоглашений);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.СоглашенияСКлиентами.Команды.ОткрытиеСпискаИндивидуальныхСоглашений);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Справочники.СоглашенияСКлиентами.Команды.СоглашенияСКлиентом);
	
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Документы.ЗаказКлиента.Команды.ЗаказыКлиентов);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Документы.ЗаказПоставщику.Команды.ЗаказыПоставщикам);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Документы.ЗаявкаНаВозвратТоваровОтКлиента.Команды.ЗаявкиНаВозвратТоваровОтКлиентов);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Документы.ЗаявкаНаРасходованиеДенежныхСредств.Команды.ЗаявкиНаОплатуПоставщикам);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Документы.ЗаявкаНаРасходованиеДенежныхСредств.Команды.ЗаявкиНаРасходованиеДенежныхСредств);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Документы.КоммерческоеПредложениеКлиенту.Команды.КоммерческиеПредложенияКлиентам);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Документы.КоммерческоеПредложениеПоставщика.Команды.КоммерческиеПредложенияПоставщиков);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Документы.ПриходныйКассовыйОрдер.Команды.ПриходныеКассовыеОрдера);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Документы.РасходныйКассовыйОрдер.Команды.РасходныеКассовыеОрдера);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Документы.СчетФактураКомиссионеру.Команды.СчетаФактурыКомиссионерам);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Документы.СчетФактураКомитента.Команды.СчетаФактурыКомитентов);
	
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПанельСправочниковБюджетирования.Команды.РазделСправочниковБюджетирование);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПанельСправочниковВнеоборотныеАктивы.Команды.РазделСправочниковВнеоборотныеАктивы);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПанельСправочниковЗарплата.Команды.РазделСправочниковЗарплата);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПанельСправочниковКадры.Команды.РазделСправочниковКадры);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПанельСправочниковМаркетинг.Команды.РазделСправочниковМаркетинг);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПанельСправочниковМеждународныйФинансовыйУчет.Команды.РазделСправочниковМФУ);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПанельСправочниковНСИ.Команды.ПанельКлассификаторыНоменклатуры);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПанельСправочниковПроизводство.Команды.РазделСправочниковПроизводство);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПанельСправочниковРегламентированныйУчет.Команды.РазделСправочниковРегламентированныйУчет);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПанельСправочниковСклад.Команды.РазделСправочниковСклад);
	
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПрайсЛист.Команды.ПрайсЛист);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПрайсЛистПоставщика.Команды.ПрайсЛистыПоставщиков);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.ПрайсЛистПоставщика.Команды.ПрайсЛистыКонкурентов);
	//ДобавитьПроверкуПросмотра(Результат, Метаданные.Обработки.СостояниеОбеспечения.Команды.СостояниеОбеспеченияЗаказов);
	
	ДобавитьПроверкуПросмотра(Результат, Метаданные.ЖурналыДокументов.ОтчетыКомиссионеров.Команды.ОтчетыКомиссионеров);
	ДобавитьПроверкуПросмотра(Результат, Метаданные.ЖурналыДокументов.ОтчетыКомитентам.Команды.ОтчетыКомитентам);

	возврат Результат;
	
КонецФункции

Процедура ДобавитьПроверкуПросмотра(Результат, ОбъектМетаданных)
	Результат.Вставить(ОбъектМетаданных, "Просмотр");
КонецПроцедуры

#КонецОбласти

Процедура СообщитьОбОшибке(ТекстСообщенияОбОшибке, Отказ)
	
	мСтрокиОшибок = Новый Массив;
	мСтрокиОшибок.Добавить(ТекстСообщенияОбОшибке);
	мт_ТестированиеКонфигурации_Служебный.СообщитьОбОшибке(мСтрокиОшибок, Отказ);
	
КонецПроцедуры

Функция ЭтоСтрокаСоединенияСРабочейБазой(СтрокаСоединенияСБазойТестирования) Экспорт
	Возврат Ложь;
КонецФункции