class Message {
  final String image;
  final String vendorImage;
  final String name;
  final String date;
  final String description;
  final String duration;

  const Message({
    required this.image,
    required this.vendorImage,
    required this.name,
    required this.date,
    required this.description,
    required this.duration,
  });
}

final List<Message> messages = [
  const Message(
    image:
        "https://images.pexels.com/photos/53464/sheraton-palace-hotel-lobby-architecture-san-francisco-53464.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    vendorImage:
        'https://images.pexels.com/photos/874158/pexels-photo-874158.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    name: 'Johny Smith',
    date: '2025-03-25',
    description:
        'Một trải nghiệm tuyệt vời tại khách sạn cao cấp với không gian sang trọng và đầy đủ tiện nghi.',
    duration: '2 hours ago',
  ),
  const Message(
    image:
        "https://toplist.vn/images/800px/khach-san-golden-lotus-luxury-362428.jpg",
    vendorImage:
        'https://images.pexels.com/photos/868113/pexels-photo-868113.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    name: 'Nguyen Tien Tung',
    date: '2025-03-24',
    description:
        'Phong cách thiết kế hiện đại, kết hợp tinh tế giữa truyền thống và đương đại.',
    duration: '5 hours ago',
  ),
  const Message(
    image:
        "https://images.pexels.com/photos/164595/pexels-photo-164595.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    vendorImage:
        'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    name: 'Maria Sakura',
    date: '2025-03-23',
    description:
        'Không gian mở với ánh sáng tự nhiên tạo cảm giác thoải mái và thân thiện.',
    duration: '1 day ago',
  ),
  const Message(
    image:
        "https://images.pexels.com/photos/2057610/pexels-photo-2057610.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    vendorImage:
        'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    name: 'Tony Bones',
    date: '2025-03-22',
    description:
        'Thiết kế tinh tế, phù hợp cho mọi nhu cầu nghỉ dưỡng và hội họp.',
    duration: '3 days ago',
  ),
  const Message(
    image:
        "https://images.pexels.com/photos/2883048/pexels-photo-2883048.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    vendorImage:
        'https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    name: 'Nguyen Thu Trang',
    date: '2025-03-21',
    description:
        'Nơi hội tụ của sự sang trọng và tiện nghi vượt trội, tạo nên trải nghiệm không thể quên.',
    duration: '1 week ago',
  ),
];
