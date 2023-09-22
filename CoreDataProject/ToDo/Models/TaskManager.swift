import UIKit
import CoreData

class TaskManager {
    static let shared = TaskManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // Task 생성 및 저장
    func createTask(title: String) {
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.title = title
        newTask.createDate = Date()
        newTask.modifyDate = Date()
        newTask.isCompleted = false

        do {
            try context.save()
        } catch {
            print("Task 저장 에러: \(error.localizedDescription)")
        }
    }
    
    // Task 삭제
    func deleteTask(task: Task) {
        context.delete(task)

        do {
            try context.save()
        } catch {
            print("Task 삭제 에러: \(error.localizedDescription)")
        }
    }

    // Task 수정
    func updateTask(task: Task, withTitle title: String) {
        task.title = title
        task.modifyDate = Date()

        do {
            try context.save()
        } catch {
            print("Task 수정 에러: \(error.localizedDescription)")
        }
    }

    // 모든 Task 가져오기
    func fetchTasks() -> [Task] {
        do {
            let tasks = try context.fetch(Task.fetchRequest()) as [Task]
            return tasks
        } catch {
            print("Task 가져오기 에러: \(error.localizedDescription)")
            return []
        }
    }
}
