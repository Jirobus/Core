'use strict';
const common = {
  setter: (object, key, result) => value => {
    object[key] = value;
    return result;
  },
  task: data => ({
    setParent: parent => (data.parent = parent),
    then: task => {
      task.setParent(data);
      return task;
    },
    toJSON: () => JSON.stringify(data)
  })
};
const Task = name => {
  const data = { type: 'simple', name };
  const result = common.task(data);
  const setters = ['name', 'description', 'fitness', 'comment'];
  for (const key of setters) result[key] = common.setter(data, key, result);
  return result;
};
Task.all = (...tasks) => {
  const data = { type: 'complex', resolveCondition: 'all', tasks };
  const result = common.task(data);
  return result;
};
Task.race = (...tasks) => {
  const data = { type: 'complex', resolveCondition: 'one', tasks };
  const result = common.task(data);
  return result;
};
console.log(
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
    )
    .toJSON()
);
