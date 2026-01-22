//
//  NotififcationManager.swift
//  IQwiz
//
//  Created by Sushant Dhakal on 2026-01-05.
//

import UserNotifications

 class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    // MARK: - Permission
    func requestPermissionAndScheduleDaily() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                if granted {
                    self.scheduleDaily()
                }
        }
    }

    // MARK: - Daily Notification
    private func scheduleDaily() {

        let content = UNMutableNotificationContent()
        content.title = "Daily Reminder"
        content.body = "Time to continue your quiz!"
        content.sound = .default

        var components = DateComponents()
        components.hour = 9
        components.minute = 0

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: "daily9AMReminder",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)

    
    }
}

