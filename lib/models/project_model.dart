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
}