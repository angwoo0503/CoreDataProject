import Foundation
import CoreData

class ToDoListViewModel {
    private let taskManager = TaskManager.shared

    var tasks: [Task] {
        return taskManager.fetchTasks()
    }

    func createTask(title: String) {
        taskManager.createTask(title: title)
    }

    func deleteTask(at index: Int) {
        let task = tasks[index]
        taskManager.deleteTask(task: task)
    }

    func updateTask(at index: Int, withTitle title: String) {
        let task = tasks[index]
        taskManager.updateTask(task: task, withTitle: title)
    }
}
