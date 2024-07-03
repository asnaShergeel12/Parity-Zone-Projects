import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zoom_widget/zoom_widget.dart';
import '../../../service/image picker option service/image_picker_option_service.dart';
import '../../../service/shared preferences service/shared_preferences_service.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_listtile.dart';
import '../../widgets/custom_popup_menu_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textbtn.dart';
import '../../widgets/custom_textformfield.dart';
import 'dashboard_appbar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dashboardKey = GlobalKey<FormState>();
  bool _isImageValid = true;
  List<List<XFile>> imageFileList = [];
  List<String> titles = [];
  List<String> descs = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  int? _editIndex;
  late PageController _pageController;
  int _currentPage = 0;
  int _selectedIndex = 0;

  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();
  final ImagePickerOptionService _imagePickerOptionService =
      ImagePickerOptionService();

  @override
  void initState() {
    super.initState();
    loadDataFromSharedPreferences();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _pageController.animateToPage(_currentPage,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      });
    }
  }

  void _nextPage() {
    if (_selectedIndex < imageFileList.length) {
      int currentLength = imageFileList[_selectedIndex].length;
      if (currentLength > 0 && _currentPage < currentLength - 1) {
        setState(() {
          _currentPage++;
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        });
      }
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    // Adjust current page if it exceeds the new length after deletion
    if (_currentPage >= imageFileList[_selectedIndex].length) {
      _currentPage = imageFileList[_selectedIndex].length - 1;
      _pageController.jumpToPage(_currentPage);
    }
  }

  String? validateFields(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
        appBar: DashboardAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.58,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    if (index < imageFileList.length) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              insetPadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.zero,
                              content: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: imageFileList.isNotEmpty
                                      ? imageFileList[_selectedIndex].length
                                      : 0,
                                  onPageChanged: _onPageChanged,
                                  itemBuilder: (context, imgIndex) {
                                    return Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Zoom(
                                            maxZoomWidth: 1800,
                                            maxZoomHeight: 1800,
                                            doubleTapZoom: true,
                                            initTotalZoomOut: true,
                                            child: Image.file(
                                              File(imageFileList[index]
                                                      [imgIndex]
                                                  .path),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 10,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.45,
                                          child: IconButton(
                                            icon: const CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Icon(Icons.arrow_back,
                                                  color: Color(0xff1e1e1a)),
                                            ),
                                            onPressed: _previousPage,
                                          ),
                                        ),
                                        Positioned(
                                          right: 10,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.45,
                                          child: IconButton(
                                            icon: const CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Icon(Icons.arrow_forward,
                                                  color: Color(0xff1e1e1a)),
                                            ),
                                            onPressed: _selectedIndex <
                                                        imageFileList.length &&
                                                    imageFileList[
                                                            _selectedIndex]
                                                        .isNotEmpty
                                                ? _nextPage
                                                : null,
                                          ),
                                        ),
                                        Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.025,
                                            right: 10,
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const CircleAvatar(
                                                backgroundColor: Colors.white70,
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                              ),
                                            )),
                                        Positioned(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                          right: 150,
                                          child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    CustomAlertDialog(
                                                  title: "Confirm Delete",
                                                  content:
                                                      "Are you sure you want to delete this image?",
                                                  onConfirm: () {
                                                    setState(() {
                                                      // Remove the specific image from the nested list
                                                      imageFileList[
                                                              _selectedIndex]
                                                          .removeAt(
                                                              _currentPage);

                                                      // Check if the list at _selectedIndex is empty after removal
                                                      if (imageFileList[
                                                              _selectedIndex]
                                                          .isEmpty) {
                                                        // Remove the entire item if the list is empty
                                                        imageFileList.removeAt(
                                                            _selectedIndex);
                                                        titles.removeAt(
                                                            _selectedIndex);
                                                        descs.removeAt(
                                                            _selectedIndex);

                                                        // Adjust _selectedIndex if it exceeds the new length after deletion
                                                        if (_selectedIndex >=
                                                            imageFileList
                                                                .length) {
                                                          _selectedIndex =
                                                              imageFileList
                                                                      .length -
                                                                  1;
                                                        }

                                                        // Automatically move to the next page if not at the last item
                                                        if (_selectedIndex >=
                                                            0) {
                                                          _currentPage =
                                                              0; // Reset to the first page of the new selected index
                                                          _pageController
                                                              .jumpToPage(
                                                                  _currentPage);
                                                        }
                                                      } else {
                                                        // Adjust the current page if deleting the last image
                                                        if (_currentPage >=
                                                            imageFileList[
                                                                    _selectedIndex]
                                                                .length) {
                                                          _currentPage =
                                                              imageFileList[
                                                                          _selectedIndex]
                                                                      .length -
                                                                  1;
                                                          _pageController
                                                              .jumpToPage(
                                                                  _currentPage);
                                                        }
                                                      }

                                                      saveDataToSharedPreference();
                                                    });
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                  onCancel: () {
                                                    Navigator.of(
                                                        context); // Close the dialog
                                                  },
                                                ),
                                              );
                                            },
                                            icon: const CircleAvatar(
                                                radius: 25,
                                                backgroundColor: Colors.white70,
                                                child: Icon(
                                                  Icons.delete_outlined,
                                                  color: Colors.red,
                                                  size: 40,
                                                )),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(imageFileList[index][0].path),
                                      width: double.infinity,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 3,
                                  right: 3,
                                  child: imageFileList[index].length > 1
                                      ? CustomContainer(
                                          padding: const EdgeInsets.all(4),
                                          color: Colors.black54,
                                          child: CustomText(
                                            text:
                                                '+${imageFileList[index].length - 1}',
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                            CustomListTile(
                              title: CustomText(
                                text: titles[index],
                                fontSize: 13.3,
                                fontWeight: FontWeight.bold,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: CustomText(
                                text: descs[index],
                                fontSize: 9.0,
                                color: const Color(0xff1e1e1a),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: CustomPopupMenuButton(
                                onSelected: (String value) {
                                  handleMenuSelection(value, index);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  openDialog(isEdit: false);
                },
                tooltip: 'Add Item',
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void openDialog({required bool isEdit, int? index}) {
    _editIndex = isEdit ? index : null;
    List<XFile>? pickedFiles =
        isEdit ? List<XFile>.from(imageFileList[index!]) : [];

    if (isEdit) {
      _titleController.text = titles[index!];
      _descController.text = descs[index!];
    } else {
      _titleController.clear();
      _descController.clear();
      pickedFiles = [];
    }

    bool isImageSelected = pickedFiles.isNotEmpty;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: CustomText(
              text: isEdit ? "Edit Item" : "Add Item",
              fontSize: 18.0,
            ),
            content: Form(
              key: _dashboardKey,
              child: SingleChildScrollView(
                child: ListBody(
                  children: [
                    CustomTextButton(
                      text: isEdit ? "Edit Images" : "Add Images",
                      txtcolor: const Color(0xff1e1e1a),
                      onPressed: () async {
                        await _imagePickerOptionService.showImagePickerOption(
                          context,
                          (List<XFile> files) {
                            setState(() {
                              pickedFiles = files;
                              isImageSelected = pickedFiles!.isNotEmpty;
                            });
                          },
                        );
                      },
                      bordercolor: isImageSelected
                          ? const Color(0xff1e1e1a)
                          : Colors.redAccent.shade700,
                    ),
                    CustomContainer(
                      width: 80,
                      height: 70,
                      child: pickedFiles!.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: pickedFiles!.length,
                              itemBuilder: (content, imgIndex) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Image.file(
                                    File(pickedFiles![imgIndex].path),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: CustomText(
                                text: 'No images selected',
                                fontSize: 9.3,
                                color: Color(0xff1e1e1a),
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                      controller: _titleController,
                      hintText: "Title",
                      hintTxtColor: const Color(0xff1e1e1a),
                      contentPadding: const EdgeInsets.only(left: 23.0),
                      validator: validateFields,
                    ),
                    const SizedBox(height: 5),
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      controller: _descController,
                      hintText: "Description",
                      contentPadding: const EdgeInsets.only(
                        left: 21.0,
                        right: 21.0,
                        top: 33.0,
                      ),
                      hintTxtColor: const Color(0xff1e1e1a),
                      maxLines: 10,
                      validator: validateFields,
                    ),
                    const SizedBox(height: 30),
                    CustomTextButton(
                      text: isEdit ? "Edit" : "Add",
                      txtcolor: Colors.white,
                      bgcolor: const Color(0xff1e1e1a),
                      onPressed: () {
                        bool isValid = _dashboardKey.currentState!.validate();
                        setState(() {
                          _isImageValid = isImageSelected && isValid;
                        });
                        if (_isImageValid) {
                          if (isEdit) {
                            setState(() {
                              titles[_editIndex!] = _titleController.text;
                              descs[_editIndex!] = _descController.text;
                              imageFileList[_editIndex!] = pickedFiles!;
                            });
                            saveDataToSharedPreference();
                          } else {
                            setState(() {
                              titles.add(_titleController.text);
                              descs.add(_descController.text);
                              imageFileList.add(pickedFiles!);
                            });
                            saveDataToSharedPreference();
                          }
                          _titleController.clear();
                          _descController.clear();
                          Navigator.of(context).pop();
                        }
                      },
                      bordercolor: const Color(0xff1e1e1a),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void saveDataToSharedPreference() async {
    await _sharedPreferencesService.saveData(titles, descs, imageFileList);
    setState(() {});
    _titleController.clear();
    _descController.clear();
    _editIndex = null;
  }

  void loadDataFromSharedPreferences() async {
    final data = await _sharedPreferencesService.loadData();
    setState(() {
      titles = data['titles'] ?? [];
      descs = data['descs'] ?? [];
      imageFileList = data['imageFileList'] ?? [];
    });
  }

  void handleMenuSelection(String value, int index) {
    switch (value) {
      case 'edit':
        _titleController.text = titles[index];
        _descController.text = descs[index];
        _editIndex = index;
        openDialog(isEdit: true, index: index);
        break;
      case 'delete':
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: "Confirm Delete",
            content: "Are you sure you want to delete this item?",
            onConfirm: () {
              setState(() {
                titles.removeAt(index);
                descs.removeAt(index);
                imageFileList.removeAt(index);
                saveDataToSharedPreference();
                Navigator.of(context).pop();
              });
            },
            onCancel: () {
              Navigator.of(context).pop();
            },
          ),
        );
        break;
    }
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool? exitApp = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const CustomText(
            text: 'Do you want to exit the app?',
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xff1e1e1a)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const CustomText(
                text: 'No', fontSize: 11, color: Color(0xff1e1e1a)),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: const CustomText(
                text: 'Yes', fontSize: 11, color: Color(0xff1e1e1a)),
          ),
        ],
      ),
    );
    return exitApp ?? false;
  }
}
