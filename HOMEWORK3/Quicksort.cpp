#include <iostream>
#include <stack>
#include <vector>

using namespace std;

//Partition function
int partition(vector<int>& arr, int low, int high) {
    int pivot = arr[high]; //Choose the last element as pivot
    int i = low - 1;       //Pointer for the smaller element
    for (int j = low; j < high; j++){
        if (arr[j] < pivot){
            i++;
            swap(arr[i], arr[j]); //Swap elements
        }
    }
    swap(arr[i + 1], arr[high]); //Place pivot in correct position
    return i + 1;
}
// Iterative Quicksort function
void quickSort(vector<int>& arr) {
    int low = 0, high = arr.size() - 1;
    stack<pair<int, int>> s; //Stack to store subarray bounds
    s.push({low, high});
    while (!s.empty()) {
        auto [low, high] = s.top();
        s.pop();
        if (low < high) {
            int pivotIndex = partition(arr, low, high);
            // Push left subarray
            if (pivotIndex - 1 > low)
                s.push({low, pivotIndex - 1});
            // Push right subarray
            if (pivotIndex + 1 < high)
                s.push({pivotIndex + 1, high});
        }
    }
}
// Utility function to print array
void printArray(const vector<int>& arr) {
    for (int num : arr)
        cout << num << " ";
    cout << endl;
}ls
int main() {
    vector<int> arr = {10, 7, 8, 9, 1, 5, 3, 6};
    
    cout << "Original array: ";
    printArray(arr);

    quickSort(arr);

    cout << "Sorted array: ";
    printArray(arr);

    return 0;
}
