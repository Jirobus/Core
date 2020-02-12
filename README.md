# Ядро системи керування проектами сталої якості Jirobus
## Вимоги
1. Реалізувати можливості по створенню моделей проектів, що складаються з послідовностей задач
2. Забезпечити закріплення певних задач за певними співробітниками
3. Забезпечити закріплення з п.2 відповідно до навичок співробітників
## Попередні концепти
### Фреймворк JiroScript для мови JavaScript
Зразок синтаксису
```javascript
Task('Medieval parliament')
  .then(
    Task()
      .name('aye')
      .fitness('Worker.isMP')
      .description('agree')
  )
  .then(
    Task()
      .name('enforce')
      .fitness('Worker.skills.martial')
      .comment('harshly')
  )
  .then(
    Task.all(
      Task('Knight')
        .fitness('(Worker.skills.martial > 10) && Worker.skills.martial')
        .description('fight'),
      Task('Priest')
        .fitness('(Worker.skills.reading > 10) && Worker.skills.reading')
        .description('pray'),
      Task('Peasant')
        .fitness('Worker.canWork')
        .description('work')
    )
  )
  .then(
    Task.race(
      Task('English way').description('migrate to constitutional monarchy'),
      Task('French way').description('migrate to republic')
    )
  );
  ```
  Приклад фреймворку для виконання коду вище можна знайти в гілці concepts у відповідній директорії
