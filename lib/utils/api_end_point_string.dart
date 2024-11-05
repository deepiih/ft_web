class EndPoint {
  static const sendotp = "sendotp";
  static const verifyotp = "verifyotp";
  static const update_profile = 'update-profile';

  static const create_project = 'create-project';
  static const create_milestone = 'create-milestone';
  static const save_project_notes = 'save-project-notes';
  static const project_add_client = 'project-add-client';
  static const get_project_info = 'get-project-info';
  static const send_for_review = 'send-for-review';
  static const get_all_projects = 'get-all-projects';
  static const delete_project = 'delete-project';
  static const reject_project = 'reject-project';
  static const request_chanage = 'request-chanage';
  static const approve_project = 'approve-project';
  static const complete_project = 'complete-project';

  static const stripe_onboarding = 'stripe-onboarding';
  static const get_dashboard = 'get-dashboard';

  static const approve_milestone = 'approve-milestone';
  static const reject_milestone = 'reject-milestone';
  static const milestone_change_request = 'milestone-change-request';
  static const get_milestone = 'get-milestone';
  static const upload_attachment = 'upload-attachment';
  static const dispute_milestone = 'dispute-milestone';
  static const refund_milestone = 'refund-milestone';
  static const complete_milestone = 'complete-milestone';
  static const delete_milestone = 'delete-milestone';

  ///task
  static const get_all_tasks = 'get-all-tasks';
  static const create_task = 'create-task';
  static const update_task = 'update-task';
  static const delete_task = 'delete-task';
  static const task_change_request = 'task-change-request';
  static const approve_task = 'approve-task';

  //not in use
  static const change_task_status = 'change-task-status';
  static const task_update_payment_status = 'task-update-payment-status';
}
