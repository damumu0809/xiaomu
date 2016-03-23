#include <iostream>
using namespace std;

//这里开始写swap不能运行 改为Swap
template<class Type>
void Swap(Type &a, Type &b){
	Type c;
	c = b;
	b = a;
	a = c;
}

template<class Type>
void perm(Type list[], int k , int m){
	if(k == m){
		for(int i = 0; i <= m; i++)
			cout<<list[i];
		cout<<endl;
	}

	else{
		for(int i = k; i <= m; i++) {
			Swap(list[k], list[i]);
			perm(list, k + 1, m);
			swap(list[k], list[i]);
		}
	}
}

int main(){
//不会输入未知个数的数组
	// int nums[100];
	// cout<<"请输入一组数，以空格隔开：";
	// for(int i = 0; ; i++ ){
	// 	cin >> nums[i];
	// }

	// perm(nums, 0 ,)

	int list[4] = {1, 2, 3, 4};
	perm(list, 0, 3);

	return 0;
}