import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:takwira_app/views/messages/chat2.dart';

class FieldBooking extends StatefulWidget {
  const FieldBooking({super.key});

  @override
  _FieldBookingState createState() => _FieldBookingState();
}

class _FieldBookingState extends State<FieldBooking> {
  final now = DateTime.now();
  late BookingService mockBookingService;

  @override
  void initState() {
    super.initState();
    mockBookingService = BookingService(
      serviceName: 'Mock Service',
      serviceDuration: 30,
      bookingStart: DateTime(now.year, now.month, now.day, 0, 0),
      bookingEnd: DateTime(now.year, now.month, now.day, 23, 59),
    );
  }

  Stream<dynamic>? getBookingStream(
      {required DateTime start, required DateTime end}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBooking({required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    // Upload the booking data
    print('${newBooking.toJson()} has been uploaded');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Chat2()),
    );
  }

  List<DateTimeRange> convertStreamResult({required dynamic streamResult}) {
    // Parse the stream result and convert to List<DateTimeRange>
    // Handle available, booked, selected, and outService states
    // This is just a mock implementation, replace it with actual logic
    return [];
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
        start: DateTime(now.year, now.month, now.day, 8, 0),
        end: DateTime(now.year, now.month, now.day, 12, 0),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Field Booking',
      // // theme: ThemeData.dark(),
      // // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.dark,
      // highContrastDarkTheme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: const Color(0xff474D48),
        body: Center(
          child: BookingCalendar(
            bookingButtonColor: Color(0xFF7EA087),
            bookedSlotColor: Color(0xffBD4747),
            bookedSlotTextStyle: TextStyle(color: Color(0xffF1EED0)),
            selectedSlotColor: Color(0xffCC901C),
            availableSlotColor: Color(0xff599068),
            availableSlotTextStyle: TextStyle(color: Color(0xffF1EED0)),
            pauseSlotColor: Color(0xffA09F8D),
            bookingService: mockBookingService,
            convertStreamResultToDateTimeRanges: convertStreamResult,
            getBookingStream: getBookingStream,
            uploadBooking: uploadBooking,
            pauseSlots: generatePauseSlots(),
            pauseSlotText: 'Closed',
            hideBreakTime: false,
            loadingWidget: const Text('Fetching data...'),
            uploadingWidget: const CircularProgressIndicator(
              color: Color(0xff599068),
            ),
            locale: 'en_TN',
            startingDayOfWeek: StartingDayOfWeek.monday,
            wholeDayIsBookedWidget:
                const Text('Sorry, for this day everything is booked'),
            //disabledDates: [DateTime(2024, 12, 31)],
            //disabledDays: [6, 7],
          ),
        ),
      ),
    );
  }
}
