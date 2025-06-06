import 'event_image_model.dart';
import 'event_tag_model.dart';

class EventModel {
  final int id;
  final String title;
  final String slug;
  final String description;
  final bool isAiGenerated;
  final String? posterImage;
  final int promotorId;
  final String promotorName;
  final int categoryId;
  final String categoryName;
  final String locationName;
  final String address;
  final double? latitude;
  final double? longitude;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime registrationStart;
  final DateTime registrationEnd;
  final bool isFree;
  final double? price;
  final int? maxAttendees;
  final bool isPublished;
  final bool isFeatured;
  final bool isApproved;
  final int viewsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Joined/calculated properties
  final int? totalAttendees;
  final bool isBookmarked;
  final List<EventImage>? images;
  final List<EventTagModel>? tags;

  EventModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    this.isAiGenerated = false,
    this.posterImage,
    required this.promotorId,
    required this.promotorName,
    required this.categoryId,
    required this.categoryName,
    required this.locationName,
    required this.address,
    this.latitude,
    this.longitude,
    required this.startDate,
    required this.endDate,
    required this.registrationStart,
    required this.registrationEnd,
    required this.isFree,
    this.price,
    this.maxAttendees,
    this.isPublished = true,
    this.isFeatured = false,
    this.isApproved = true,
    this.viewsCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.totalAttendees,
    this.isBookmarked = false,
    this.images,
    this.tags,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    // Handle nested promotor object
    final promotor = json['promotor'] as Map<String, dynamic>?;
    final promotorId = promotor?['id'] as int? ?? json['promotor_id'] as int?;
    final promotorName =
        promotor?['name'] as String? ?? json['promotor_name'] as String? ?? '';

    // Handle nested category object
    final category = json['category'] as Map<String, dynamic>?;
    final categoryId = category?['id'] as int? ?? json['category_id'] as int?;
    final categoryName =
        category?['name'] as String? ?? json['category_name'] as String? ?? '';

    // Get registration dates with fallback
    final registrationStart = json['registration_start']?.toString();
    final registrationEnd = json['registration_end']?.toString();
    final now = DateTime.now();

    final event = EventModel(
      id: json['id'],
      title: json['title']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      isAiGenerated: json['is_ai_generated'] == 1,
      posterImage: json['poster_image']?.toString(),
      promotorId: promotorId ?? 0,
      promotorName: promotorName,
      categoryId: categoryId ?? 0,
      categoryName: categoryName,
      locationName: json['location_name']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      latitude: json['latitude'] != null
          ? double.parse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.parse(json['longitude'].toString())
          : null,
      startDate: DateTime.parse(
          json['start_date']?.toString() ?? now.toIso8601String()),
      endDate: DateTime.parse(json['end_date']?.toString() ??
          now.add(const Duration(days: 1)).toIso8601String()),
      registrationStart:
          DateTime.parse(registrationStart ?? now.toIso8601String()),
      registrationEnd: DateTime.parse(registrationEnd ??
          now.add(const Duration(days: 30)).toIso8601String()),
      isFree: json['is_free'] == 1,
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : null,
      maxAttendees: json['max_attendees'],
      isPublished: json['is_published'] == 1,
      isFeatured: json['is_featured'] == 1,
      isApproved: json['is_approved'] == 1,
      viewsCount: json['views_count'] ?? 0,
      createdAt: DateTime.parse(
          json['created_at']?.toString() ?? now.toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at']?.toString() ?? now.toIso8601String()),
      totalAttendees: json['total_attendees'],
      isBookmarked: json['is_bookmarked'] == 1,
      images: json['images'] != null
          ? (json['images'] as List).map((i) => EventImage.fromJson(i)).toList()
          : null,
      tags: json['tags'] != null
          ? (json['tags'] as List)
              .map((i) => EventTagModel.fromJson(i))
              .toList()
          : null,
    );
    return event;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'is_ai_generated': isAiGenerated ? 1 : 0,
      'poster_image': posterImage,
      'promotor_id': promotorId,
      'promotor_name': promotorName,
      'category_id': categoryId,
      'category_name': categoryName,
      'location_name': locationName,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'registration_start': registrationStart.toIso8601String(),
      'registration_end': registrationEnd.toIso8601String(),
      'is_free': isFree ? 1 : 0,
      'price': price,
      'max_attendees': maxAttendees,
      'is_published': isPublished ? 1 : 0,
      'is_featured': isFeatured ? 1 : 0,
      'is_approved': isApproved ? 1 : 0,
      'views_count': viewsCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'total_attendees': totalAttendees,
      'is_bookmarked': isBookmarked ? 1 : 0,
    };

    if (images != null) {
      data['images'] = images!.map((image) => image.toJson()).toList();
    }

    if (tags != null) {
      data['tags'] = tags!.map((tag) => tag.toJson()).toList();
    }

    return data;
  }

  EventModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? description,
    bool? isAiGenerated,
    String? posterImage,
    int? promotorId,
    String? promotorName,
    int? categoryId,
    String? categoryName,
    String? locationName,
    String? address,
    double? latitude,
    double? longitude,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? registrationStart,
    DateTime? registrationEnd,
    bool? isFree,
    double? price,
    int? maxAttendees,
    bool? isPublished,
    bool? isFeatured,
    bool? isApproved,
    int? viewsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalAttendees,
    bool? isBookmarked,
    List<EventImage>? images,
    List<EventTagModel>? tags,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      isAiGenerated: isAiGenerated ?? this.isAiGenerated,
      posterImage: posterImage ?? this.posterImage,
      promotorId: promotorId ?? this.promotorId,
      promotorName: promotorName ?? this.promotorName,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      locationName: locationName ?? this.locationName,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      registrationStart: registrationStart ?? this.registrationStart,
      registrationEnd: registrationEnd ?? this.registrationEnd,
      isFree: isFree ?? this.isFree,
      price: price ?? this.price,
      maxAttendees: maxAttendees ?? this.maxAttendees,
      isPublished: isPublished ?? this.isPublished,
      isFeatured: isFeatured ?? this.isFeatured,
      isApproved: isApproved ?? this.isApproved,
      viewsCount: viewsCount ?? this.viewsCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalAttendees: totalAttendees ?? this.totalAttendees,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      images: images ?? this.images,
      tags: tags ?? this.tags,
    );
  }

  // Calculate if registration is currently open
  bool get isRegistrationOpen {
    final now = DateTime.now();
    return now.isAfter(registrationStart) && now.isBefore(registrationEnd);
  }

  // Calculate if event is ongoing
  bool get isOngoing {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  // Calculate if event has ended
  bool get hasEnded {
    return DateTime.now().isAfter(endDate);
  }

  // Check if event is at full capacity
  bool get isFullCapacity {
    return maxAttendees != null &&
        totalAttendees != null &&
        totalAttendees! >= maxAttendees!;
  }
}
