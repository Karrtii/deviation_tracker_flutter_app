class ProjectModel
{
  final String projectId;
  final String projectName;

  ProjectModel({required this.projectId, required this.projectName});

  static ProjectModel fromJson(json)
  {
    return ProjectModel(
        projectId: json["projectId"],
        projectName: json["projectName"]
    );
  }

  static Map<String, dynamic> toJson(ProjectModel project) {
    Map<String, dynamic> jsonMap = {
      "projectId": project.projectId,
      "projectName": project.projectName
    };

    return jsonMap;
  }
}