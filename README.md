# "NewTinder" for Scientist
## Варианты названий
1. CAFS - Cool app for finding student - supervisor
2. Sciender
## Описание проекта
### Идея
  Приложение для удобного взаимодействия студентов и научных руководителей в формате популярной социальной сети «Тиндер».
### Цель
  Улучшить процесс взаимодействия студентов и преподавателей в научной области, а также повысить эффективность поиска интересных для пользователя научных проектов.
### Основная задача
  Разработка мобильного приложения для iOS.
### Краткое описание
  Благодаря приложению студенты смогут находить научных руководителей, задавая поиск по факультету, университету или даже городу, просматривать предлагаемые темы для научных работ и отзывы других студентов, подавать заявки на участие в заинтересовавших их проектах. А преподаватели, в свою очередь, будут иметь возможность оценить имеющиеся навыки студентов, подавших заявку, а также изучить их прошлые работы.

  Новизна проекта состоит в значительном увеличении получаемой при поиске информации, то есть вместо привычной темы и ФИО руководителя/студента, пользователь уже на стадии поиска сможет получить всю необходимую для совместной научной работы информацию и принять решение о подаче или одобрении заявки. В отличие от существующей в ВШЭ формы подачи заявок на участие в проектной деятельности, использование приложения позволит избежать необходимости постоянного заполнения анкеты с данными и предотвратить долгий процесс отбора кандидатов. Кроме того, преимуществом является определенно новый для рассматриваемой области формат проекта – мобильное приложение.
## Экраны
1. Основной экран (свайпалка: свайп влево - отказ, свайп вправо - лайк; после свайпа необходимо указать желаемую тему) предназначен только для студентов и содержит такие элементы, как:
  * Фото (для возможности узнать друг друга при переходе к очному взаимодействию);
  * Тэги основных тем (для того чтобы обозначить интересующую область/увлечения);
  * Краткая основная информация (у преподавателей: ФИО, департамент/кафедра; у студентов: ФИ, курс, специальность);
  * Кнопка для перехода к просмотру полной основной информации (для отображении информации из профиля и отзывов).
2. Экран “Заявки” с перечнем студентов, откликнувшихся на идею (только для научного руководителя/преподавателя).
3. Экран “Профиль” заполняется пользователем. При заполнении указываются:
  * ФИО;
  * Фото;
  * Пол;
  * Город;
  * Университет;
  * Департамент или курс/специальность;
  * Тэги основных тем (область интересов/увлечения);
  * Основные темы научных работ/проектов;
  * Описание/дополнительная информация (графа “О себе”);
  * Почта/телефон/ссылки на социальные сети/страничка на сайте университета (актуально для преподавателей).
4. Экран “Авторизация”: Авторизация в приложении.
5. Экран “Регистрация”: Регистрация в приложении.
6. Экран “Настройки”:
* Радиус (факультет/университет/город);
* Цветовая тема (темная/светлая);
* Выбор языка (по возможности).
7. Экран “Чат”(по возможности). Со стороны преподавателей: чат со студентами, отправившими заявку; со стороны студентов: чат с научным руководителем выбранного проекта.
## Бизнес-логика
  При первом запуске приложения необходимо будет зарегистрироваться (экран “Регистрация”), после чего заполнить всю необходимую информацию (экран “Профиль”). Если у пользователя уже есть аккаунт, то при первом запуске необходимо будет авторизоваться (экран “Авторизация”). Также приложение позволит переключать основные настройки (экран “Настройки”), такие как радиус, цветовая тема и язык (по возможности).

  Далее, если пользователь зарегистрировался как студент, он сможет перейти к поиску научного руководителя (темы для научной работы) при помощи основного экрана, при этом для получения полной информации нужно будет перейти к  профилю преподавателя. После того, как тема для проекта будет найдена, студент сможет отправить заявку преподавателю с указанием этой темы (основной экран).

  Пользователь, зарегистрировавшийся как преподаватель, для просмотра отправленных ему заявок будет использовать экран “Заявки”, где будут отображаться все заявки от студентов с указанными ими темами.
  Кроме того, предполагается реализация экрана “Чат” (по возможности), позволяющего общаться пользователям (студент - преподаватель), имеющим общие научные интересы.

## Сервер
Предположительно [firebase.google.com](firebase.google.com)
## RoadMap
![roadmap](./road_map.png)
## Авторы
* Мельников Иван *GnomeTV*
* Травкин Павел *Determinant179*
* Кузьмин Дмитрий *Arhangel69*
* Алена Цеплина *Alyo135*
