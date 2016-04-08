#include <iostream>
using namespace std;

int main{
	//数组第0位不赋值
	int arr[10] = {NULL, 1, 3, 5, 9, 12, 30, 45, 61, 83}; 
	//cout<<binarySearch(9, arr);
	int a = (1+4)/2;
	cout<<a;
	return 0;
}
	


//返回等于num的数字位置，如果不存在，返回0
int binarySearch(int num, int arr[]){
	int pos = 0;
	int low = 1, high = 9, mid = 0;
	while(low < high){
		mid = (low + high)/2;
		if(num == arr[mid]){
			pos = mid;
			break;
		}
		if(num < arr[mid]){
			high = mid - 1;
		}
		else{
			low = mid +1;
		}
	}
}