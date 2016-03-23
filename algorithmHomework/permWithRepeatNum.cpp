#include <iostream>
using namespace std;

template<class Type>
void Swap(Type &a, Type &b){
	Type c;
	c = b;
	b = a;
	a = c;
}

template<class  Type>
int * findRepeat(Type list[], int k, int m){
	int repeat[100] = {0};
	int n =0;
	for(int i = k; i<= m; i++ ){
		for(int j = i+1; j <= m; j++){
			if(list[i] == list[j]){
				repeat[n] = i;
				n++;
				break;
			}
				
		}
	}
	//检测repeat数组是否正确，正确
	// for(n = 0; n < 100; n++){
	// 	cout<< repeat[n];
	// }

	return repeat;


}



template<class Type>
void perm(Type list[], int k , int m){
	if(k == m){
		for(int i = 0; i <= m; i++)
			cout<<list[i];
		cout<<endl;
	}

	//思路是在每次perm的数组挑选出来做第一位的时候，省去出现过的
	//开始设置数组repeat存放出现过的数的下标 但是每次数组是动态的 很难实现
	//构造函数findRepeat() 每次找出在k-m之间重复的数的下标 在挑选时跳过！！！但是数组要确定大小 还是很麻烦 ？！
	else{	
		
		bool haveRepeated = 0;
		int *repeat;
		for(int i = k; i <= m; i++) {
			repeat = findRepeat(list, k, m);
			for(int n = 0; n <= 100; n++){
				if(repeat[n] == i){
					haveRepeated = 1;
					break;
				}
			}

			if(!haveRepeated){
				Swap(list[k], list[i]);
				perm(list, k + 1, m);
				swap(list[k], list[i]);
			}
			
		}
	}
}

int main(){
	int list[4] = {1,3,3,2};
	perm(list, 0 , 3);
	return 0;
}