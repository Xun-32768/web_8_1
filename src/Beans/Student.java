package Beans;

public class Student {
    int id;
    String name;
    String sex;
    int age;
    double weight;
    double height;
    public Student(){}
    public Student(int id ,String name,String sex,int age,double weight ,double height)
    {
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.age = age;
        this.weight = weight;
        this.height = height;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }
}
