import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandbox_notes_app/controllers/note_controller.dart';
import 'package:sandbox_notes_app/screens/note_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteController = Get.put(NoteController());
    return Scaffold(
      body: Obx(
        () =>
            noteController.notes.isEmpty
                ? emptyState(context)
                : Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logo-trans.png",
                        opacity: const AlwaysStoppedAnimation(0.1),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.viewPaddingOf(context).top + 24,
                      ),
                      width: MediaQuery.sizeOf(context).width,
                      child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        runSpacing: 16,
                        children: [
                          for (
                            int index = 0;
                            index < noteController.notes.length;
                            index++
                          ) ...[
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => NoteDetailScreen(
                                    note: noteController.notes[index],
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.45,
                                height: MediaQuery.sizeOf(context).width * 0.5,
                                child: Card(
                                  color: Color(0xff394675),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          noteController.notes[index].title ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(color: Colors.white),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Expanded(
                                          child: Text(
                                            noteController
                                                    .notes[index]
                                                    .content ??
                                                '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
      ),

      floatingActionButton: FloatingActionButton(
        shape: ShapeBorder.lerp(null, const CircleBorder(), 0.0),
        backgroundColor: Color(0xFF394675),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Get.to(() => NoteDetailScreen());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget emptyState(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      SizedBox(),
      Column(
        children: [
          Center(child: Image.asset("assets/images/empty-state.png")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              children: [
                Text(
                  "Start your journey",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(height: 16),
                Text(
                  "Every big step start with small step. Notes your first idea and start your journey!",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Image.asset("assets/images/Arrow.png"),
        ],
      ),
    ],
  );
}
