// News.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель для заполнения новостей
struct News {
    // MARK: - Public Properties

    /// Название источника  Новости (человек, группа)
    let sourceNews: String
    /// Картинка источника Новости
    let sourceImageName: String
    /// Основной текст новости
    let sourceText: String
    /// Основная картинка Новости
    let sourceMainImagename: String?
    /// Количество лайков
    let likes: String
    /// Количество комментариев
    let comments: String
    /// Количество просмотров
    let views: String
    /// Количество репостов
    let repost: String
    /// картинка для описания новости
    let photo: String
}
