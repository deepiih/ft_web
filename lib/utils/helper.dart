import 'package:sectar_web/package/config_packages.dart';


const plannedTask = "Planned";
const Color plannedTaskColor = Color(0xFF7E8195);
const toDoTask = "To Do";
const Color toDoTaskColor = Color(0xFFF04848);
const inProgressTask = "In Progress";
const Color inProgressTaskColor = Color(0xFF2949F4);
const underReviewTask = "Under Review";
const Color underReviewTaskColor = Color(0xFF82E4D8);
const changesRequestedTask = "Changes Requested";
const Color changesRequestedTaskColor = Color(0xFFFF965A);
const approvedTask = "Approved";
const Color approvedTaskColor = Color(0xFF34A853);

const onHoldTask = "On Hold";
const paidOutTask = "Paid out";

const draft = "Draft";
const underReview = "Under Review";
const changesNeeded = "Changes Needed";
const rejected = "Rejected";
const live = "Live";
const completed = "Completed";
const onHold = "On hold";


final List<Map<String, dynamic>> taskStatusList = [
  {"status": plannedTask, "color": plannedTaskColor},
  {"status": toDoTask, "color": toDoTaskColor},
  {"status": inProgressTask, "color": inProgressTaskColor},
  {"status": underReviewTask, "color": underReviewTaskColor},
];

Color getTaskStatusColor(String taskStatus) {
  if (taskStatus.toLowerCase() == plannedTask.toLowerCase()) {
    return plannedTaskColor;
  } else if (taskStatus.toLowerCase() == toDoTask.toLowerCase()) {
    return toDoTaskColor;
  } else if (taskStatus.toLowerCase() == inProgressTask.toLowerCase()) {
    return inProgressTaskColor;
  } else if (taskStatus.toLowerCase() == underReviewTask.toLowerCase()) {
    return underReviewTaskColor;
  } else if (taskStatus.toLowerCase() == changesRequestedTask.toLowerCase()) {
    return changesRequestedTaskColor;
  } else if (taskStatus.toLowerCase() == approvedTask.toLowerCase()) {
    return approvedTaskColor;
  } else if (taskStatus.toLowerCase() == onHoldTask.toLowerCase()) {
    return approvedTaskColor;
  } else if (taskStatus.toLowerCase() == paidOutTask.toLowerCase()) {
    return approvedTaskColor;
  }
  return Colors.black;
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

String? getStatusImage({required String status}) {
  if (status.toLowerCase() == rejected.toLowerCase()) {
    return AppImage.rejected;
  } else {
    return AppImage.information;
  }
}

String? getProjectStatusContent(String status, String client, String freelancer) {
  if (status.toLowerCase() == underReview.toLowerCase()) {
    return "This project has been sent for a review to $client by $freelancer. We will keep you posted when there is an update.";
  } else if (status.toLowerCase() == rejected.toLowerCase()) {
    return "This project is marked as ‘rejected’ by $client, the client.  \n\nSectar has sent emails to $client, and $freelancer regarding the same.";
  } else if (status.toLowerCase() == draft.toLowerCase()) {
    return "The project is still under draft. Please add first milestone details and other info to send it for review to the client.";
  } else if (status.toLowerCase() == changesNeeded.toLowerCase()) {
    return "$client, the client, has requested some changes on this project. Sectar will send emails to $client, and $freelancer, when there is an update";
  }
  return null;
}

String? getMilestoneStatusContent(String status, String client, String freelancer, {String? date}) {
  if (status.toLowerCase() == underReview.toLowerCase()) {
    return "This milestone has been sent for a review to $client by $freelancer. We will keep you posted when there is an update.";
  } else if (status.toLowerCase() == rejected.toLowerCase()) {
    return "This milestone was marked as rejected by $client on ${DateFormat(CommonDateFormat.E_d_MMMM_y).format(
      DateTime.parse(date ?? ""),
    )}";
  }
  else if (status.toLowerCase() == changesNeeded.toLowerCase()) {
    return "The client, $client, has requested for some changes to the milestone. We’ve sent you an email with the changes. Please update and resend the milestone for review.";
  } else if (status.toLowerCase() == completed.toLowerCase()) {
    return "This milestone has been successfully marked as completed on ${DateFormat(CommonDateFormat.E_d_MMMM_y).format(
      DateTime.parse(date ?? ""),
    )}. Congratulations.";
  } else if (status.toLowerCase() == onHold.toLowerCase()) {
    return "The milestone is marked as dispute and is put on hold. We are working on it to find a resolution. For queries, please email to us at \nsupport@sectar.co";
  }
  return null;
}

String getInitials(String fullName) {
  List<String> nameParts = fullName.split(" ");
  String initials = "";

  if (nameParts.length > 1) {
    for (int i = 0; i < nameParts.length; i++) {
      initials += nameParts[i][0];
    }
  } else {
    initials = fullName.substring(0, 1);
  }

  return initials;
}
