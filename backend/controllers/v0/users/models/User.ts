import {Table, Column, Model, HasMany, PrimaryKey, CreatedAt, UpdatedAt, Unique, AutoIncrement} from 'sequelize-typescript';

@Table
export class User extends Model<User> {
  
  @PrimaryKey
  @Column
  public email!: string;

  @Unique
  @AutoIncrement
  @Column
  public userID: number;

  @Column
  public password_hash!: string; // for nullable fields

  @Column
  public first_name!: string; // for nullable fields
  
  @Column
  public last_name!: string; // for nullable fields

  @Column
  public classStanding: string; // for nullable fields

  @Column
  public major: string; // for nullable fields

  @Column
  public housing: string; // for nullable fields


  @Column
  @CreatedAt
  public createdAt: Date = new Date();

  @Column
  @UpdatedAt
  public updatedAt: Date = new Date();

  short() {
    return {
      email: this.email,
      first_name: this.first_name,
      last_name: this.last_name,
    }
  }
}